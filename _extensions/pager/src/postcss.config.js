module.exports = {
    plugins: [
        require('postcss-combine-duplicated-selectors'),
        // require('postcss-preset-env'),
        // require('postcss-calc')
        require('cssnano')({
            preset: ['lite', {
                normalizeWhitespace: false,
                discardComments: false,
                calc: true,
                discardOverridden: true,
                svgo: true,
            }]
        })
    ]
}