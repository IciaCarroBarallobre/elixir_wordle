// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")

module.exports = {
  mode: 'jit',
  content: [
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/*.html.heex",
    "../../core/lib/schemas/*.ex",
    "../**/components/**/*.ex",
    "../lib/web/components.ex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js"
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
        darkest_purple: "#3e0660",
        dark_purple: "#59098A",
        purple: "#AC82C1",
        light_purple: "#CCB2D9",
        lightest_purple: "#EFE0F7"
      },
      keyframes: {
        'flicker': {
          '0%, 31.98%, 32.82%, 34.98%, 35.72%, 36.98%, 37.62%,  67.98%, 68.42%, 95.98%, 96.72%, 98.98%, 99.62%, 100%': { opacity: 1 },
          '32%, 32.8%, 35%, 35.7%, 37%, 37.6%, 68%, 68.4%, 96%, 96.7%, 99%, 99.6%': { opacity: 0 }
        },
        'pop': {
          '0%, 100%': { transform: 'scale(1)' },
          '10%': { transform: 'scale(0.8)' },
          '50%': { transform: 'scale(1.1)' }
        },
        'flip': {
          '0%': { transform: 'scaleY(1)' },
          '50%': { transform: 'scaleY(0)', 'background-color': 'transparent', 'border-color': 'transparent' },
          '100%': { transform: 'scaleY(1)' },

        }
      },
      animation: {
        'flicker': 'flicker 2s linear infinite both',
        'pop': 'pop 0.3s linear 1',
        'flip': 'flip 1s ease forwards'
      },
      transitionDelay: {
        '450': '450ms',
        '600': '600ms',
        '750': '750ms',
        '900': '900ms',
        '1050': '1050ms',
        '1200': '1200ms',
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    plugin(({ addVariant }) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),
    plugin(({ matchUtilities, theme }) => {
      matchUtilities(
        { "animate-delay": (value) => { return { "animation-delay": value } } },
        { values: theme("transitionDelay") });
    })
  ],
  safelist: [
    "animate-delay-150",
    "animate-delay-300",
    "animate-delay-450",
    "animate-delay-600",
    "animate-delay-750",
    "animate-delay-900",
    "animate-delay-1050",
    "animate-delay-1200"

  ],
}