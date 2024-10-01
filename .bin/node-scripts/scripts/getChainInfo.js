const mempoolJS = require('@mempool/mempool.js')
const { get } = require('axios')
const Numeral = require('numeral')

function clamp(num, min, max) {
    return Math.min(Math.max(num, min), max)
}
const main = async () => {
    const {
        bitcoin: { fees, difficulty, blocks, mempool },
    } = mempoolJS({
        hostname: 'mempool.space',
    })

    const recomendedFees = await fees.getFeesRecommended()

    const feeInfo = [
        recomendedFees.economyFee,
        recomendedFees.hourFee,
        recomendedFees.halfHourFee,
        recomendedFees.fastestFee,
    ]

    const diffAdjustInfo = await difficulty.getDifficultyAdjustment()
    let diffChange = `${diffAdjustInfo.difficultyChange.toFixed(2)}%`
    if (!diffAdjustInfo.difficultyChange) {
        // Mimick mempool.space and display no percentage
        diffChange = `—.——`
    }

    // const PROGRESS_ICONS = ['󰋙', '󰫃', '󰫄', '󰫅', '󰫆', '󰫇', '󰫈']
    // const segmentSize = 100 / PROGRESS_ICONS.length
    // const index = Math.floor(diffAdjustInfo.progressPercent.toFixed(2) / segmentSize)
    // const icon = PROGRESS_ICONS[clamp(index, 0, PROGRESS_ICONS.length)]
    const diffInfo = [
        `${diffAdjustInfo.progressPercent.toFixed(2)}%`,
        Numeral(diffAdjustInfo.remainingBlocks).format(),
        diffChange,
    ]

    const currHeight = await blocks.getBlocksTipHeight()

    const currMempool = await mempool.getMempool()

    const mempoolInfo = [
        Numeral(currMempool.count).format(),
        (currMempool.vsize / 1e6).toFixed(2),
        `${(currMempool.total_fee / 1e8).toFixed(2)}`,
    ]

    // the rest of this isnt in the mempool module
    const { currentHashrate } = (await get('https://mempool.space/api/v1/mining/hashrate/7d')).data

    const currHashrate = (currentHashrate / Number(1000000000000000000n)).toFixed(2) // EH/s

    const finalInfo = [
        Numeral(currHeight).format(),
        feeInfo.join(`-`),
        mempoolInfo.join(' '),
        diffInfo.join(' '),
        currHashrate,
    ]

    return `${finalInfo.join(' | ')}`
    // array.join is my favorite function
}

main()
    .then(console.log)
    .catch((e) => console.log(`Failed to fetch info.\n${e}`))
