// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")

module.exports = {
  mode: 'jit',
  content: [
    "./js/**/*.js",
    "../lib/*_web.ex",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    fontFamily: {
      'mono': ['ui-monospace', 'SFMono-Regular'],
      'body': ['"SFMono-Regular"',],
    },
    extend: {
      gridTemplateColumns: {
        '13': 'repeat(13, minmax(0, 1fr))',
        '14': 'repeat(14, minmax(0, 1fr))',
      },
      colors: {
        darkest_purple: "#59098A",
        dark_purple: "#59098A",
        purple: "#AC82C1",
        light_purple: "#CCB2D9",
        lightest_purple: "#EFE0F7"
      },
      keyframes: {
        'flicker': {
          '0%, 31.98%, 32.82%, 34.98%, 35.72%, 36.98%, 37.62%,  67.98%, 68.42%, 95.98%, 96.72%, 98.98%, 99.62%, 100%': { opacity: 1 },
          '32%, 32.8%, 35%, 35.7%, 37%, 37.6%, 68%, 68.4%, 96%, 96.7%, 99%, 99.6%': { opacity: 0 }
        }
      },
      animation: {
        'flicker': 'flicker 2s linear infinite both',
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    plugin(({ addVariant }) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"]))
  ]
}