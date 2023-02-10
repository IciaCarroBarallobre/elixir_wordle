// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import 'phoenix_html';
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from 'phoenix';
import { LiveSocket } from 'phoenix_live_view';
import topbar from '../vendor/topbar';

const cloneAlpineJSData = (from, to) => {
  if (!window.Alpine || !from || !to) return;

  for (let index = 0; index < to.children.length; index++) {
    const from2 = from.children[index];
    const to2 = to.children[index];

    if (from2 instanceof HTMLElement && to2 instanceof HTMLElement) {
      cloneAlpineJSData(from2, to2);
    }
  }

  if (from._x_dataStack) window.Alpine.clone(from, to);

  // Set `x-persist="type,style.height,style.minHeight"` to prevent these attributes from being overrided by an LV update
  // persistAttributes(from, to, from.getAttribute('x-persist'));
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
  dom: {
    onNodeAdded(node) {
      if (node._x_dataStack) {
        // window.Alpine.initTree(node);
      }
    },
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        // console.log(from._x_dataStack);
        // window.Alpine.closestRoot(from).remove();
        // window.Alpine.nextTick(() => {
        //   window.Alpine.initTree(to);
        // });
        // window.Alpine.clone(from, to);
        // window.Alpine.flushAndStopDeferringMutations();
        // window.Alpine.clone(from, to);
        // cloneAlpineJSData(from, to);
        window.Alpine.clone(from, to);
      }
    },
  },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#29d' }, shadowColor: 'rgba(0, 0, 0, .3)' });
window.addEventListener('phx:page-loading-start', (info) =>
  topbar.delayedShow(200)
);
window.addEventListener('phx:page-loading-stop', (info) => topbar.hide());
// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
// window.Alpine.start();
// import {
//   install,
//   uninstall,
// } from 'https://unpkg.com/@github/hotkey@latest?module';
// document.addEventListener('alpine:init', () => {
//   console.log('hi');
//   window.Alpine.directive('hotkeys', (el, { expression }, { cleanup }) => {
//     console.log('ran');
//     window.githubhotkey.install(el, expression);
//     cleanup(() => {
//       window.githubhotkey.uninstall(el);
//     });
//   });
// });
