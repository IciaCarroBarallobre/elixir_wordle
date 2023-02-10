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
        brand: "#FD4F00",
        elixir: "#59098A",
        elixir_700: "#AC82C1",
        elixir_300: "#CCB2D9",
        elixir_100: "#EFE0F7"
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