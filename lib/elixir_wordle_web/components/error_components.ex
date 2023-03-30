defmodule ElixirWordleWeb.ErrorComponents do
  @moduledoc """
  Provides core error components.
  """
  use Phoenix.Component

  attr(:text, :string, default: "")
  attr(:id, :string, default: nil)

  def image_error(assigns) do
    ~H"""
    <svg width="255" height="212" viewBox="0 0 255 212" class="mx-auto w-fit" id={@id}>
      <g fill="none" fill-rule="evenodd" transform="translate(-167.95728,-64.975157)">
        <g>
          <path
            style="fill:#f4eef7;fill-opacity:1;stroke:none;stroke-width:0.941141px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
            d="m 205.1662,82.080452 c 50.24956,7.73239 21.33847,-23.50577 83.60788,-15.90263 37.91791,7.85291 22.45424,32.38692 73.07805,17.85146 20.60691,-1.66044 66.47429,-1.03119 53.05267,64.373508 -9.25293,20.77601 19.62251,40.49066 2.53693,63.68477 -25.7055,29.99309 -6.69872,65.79024 -39.29393,60.70406 -68.59308,-18.32297 -61.97383,14.47902 -105.15211,1.4724 -54.61452,-32.18336 -73.24918,10.19595 -96.92222,-44.79318 -6.98192,-41.94519 16.28885,-32.30988 1.86751,-54.91605 -24.13513,-46.79681 -0.35037,-91.982238 27.22522,-92.474338 z"
          />
          <g
            class="animate-flicker"
            stroke="#fdba55"
            stroke-linecap="round"
            stroke-width="1.8"
            transform="rotate(-0.51355032,24267.314,3632.1363)"
            style="fill:none;fill-opacity:1;stroke:#a284b1;stroke-opacity:1"
          >
            <path
              d="m 287.95965,-20.477324 2.957,-2.949 m -12.046,1.632 -1.998,-3.669 m 7.196,2.733 0.479,-3.309 m -11.709,28.0639999 -3.043,2.862 m 12.088,-1.28 1.891,3.724 m -7.113,-2.94 -0.575,3.293"
              style="fill:none;fill-opacity:1;stroke:#a284b1;stroke-opacity:1"
            />
          </g>
          <text
            xml:space="preserve"
            style="font-size:18px;line-height:1.25;letter-spacing:0px;white-space:pre;inline-size:183.953;display:inline;fill:#3e035b;fill-opacity:1;stroke:none;stroke-width:0.470215;stroke-opacity:1"
            x="240"
            y="-30"
            transform="translate(-43.716995,149.77458)"
          >
            <tspan x="220" y="-10">
              <%= @text %>
            </tspan>
          </text>
          <g
            transform="translate(-3.2135821,132.70922)"
            style="fill:none;fill-opacity:1;stroke:#3e035b;stroke-opacity:1"
          >
            <path
              style="fill:none;fill-opacity:1;stroke:#3e035b;stroke-width:5;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1"
              d="m 231.64659,68.361877 c -30.67838,-0.0412 -39.20608,-24.70449 -24.31924,-26.7969 20.26347,-3.05284 11.25763,-15.083557 1.06544,-26.257797 -26.7095,-35.10074 9.76317,-40.058366 19.19803,-36.477836 v 0 c 14.71001,5.34208 29.3723,4.092388 28.72783,-11.652572 -1.7025,-28.185036 11.76451,-21.946957 28.94781,-22.88867"
            />
          </g>
          <path
            style="fill:none;fill-opacity:1;stroke:#3e035b;stroke-width:4.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1"
            d="m 271.31304,211.61054 c 4.65031,1.38857 9.76811,3.05512 12.44194,4.62717 5.01623,3.42956 0.84079,8.5805 -2.9495,12.87028 -1.60014,2.04531 -4.4825,4.14049 -2.44094,9.55023 4.1894,7.90535 48.02581,-24.30399 57.74772,-25.98915"
          />
          <rect
            style="fill:#3e035b;fill-opacity:1;stroke:none;stroke-width:4.34766;stroke-linecap:round"
            width="14.035882"
            height="1.6599338"
            x="297.60254"
            y="130.55426"
            ry="0.8299669"
            transform="rotate(16.094428)"
          />
          <rect
            style="fill:#3e035b;fill-opacity:1;stroke:none;stroke-width:4.34766;stroke-linecap:round"
            width="14.035882"
            height="1.6599338"
            x="298.40247"
            y="124.38049"
            ry="0.8299669"
            transform="rotate(16.094428)"
          />
          <path
            style="fill:#3e035b;fill-opacity:1;stroke:#3e035b;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
            d="m 256.10215,215.64966 4.04184,-15.08434 c 6.21559,1.58225 13.93064,1.79637 12.59116,11.48434 -4.42591,8.64732 -9.32,5.573 -16.633,3.6 z"
          />
          <path
            style="fill:#3e035b;fill-opacity:1;stroke:#3e035b;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
            d="m 242.26333,196.40018 -4.04184,15.08434 c -6.21559,-1.58225 -13.93064,-1.79637 -12.59116,-11.48434 4.42591,-8.64732 9.32,-5.573 16.633,-3.6 z"
          />
          <g>
            <rect
              style="fill:#885ba2;fill-opacity:1;stroke:none;stroke-width:3.38845;stroke-linecap:round;stroke-opacity:1"
              width="60.52483"
              height="81.714714"
              x="319.10458"
              y="171.34245"
              ry="3.4996772e-06"
              transform="rotate(-0.34857248)"
            />
            <path
              style="fill:#3e035b;fill-opacity:1;stroke:none;stroke-width:0.892396px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 316.01438,245.61168 -1.17341,-72.42818 c -0.0237,-3.88969 2.06433,-3.84695 7.9256,-3.92073 l 0.65202,70.77626 c 0,0 -6.69077,2.39484 -7.40421,5.57265 z"
            />
            <rect
              style="fill:#f6f0f9;fill-opacity:1;stroke:none;stroke-width:4.48756;stroke-linecap:round;stroke-opacity:1"
              width="61.5891"
              height="7.4717035"
              x="316.53189"
              y="243.74458"
              ry="0"
              transform="rotate(-0.34857248)"
            />
            <path
              style="fill:#885ba2;fill-opacity:1;stroke:none;stroke-width:0.895805px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 320.72002,251.11065 60.03736,-0.36525 -0.0112,-1.84399 -60.39797,0.36745 c 0,0 -1.89164,0.26398 -2.27285,-3.11761 -0.38121,-3.38163 1.68653,-4.34441 1.68653,-4.34441 l 60.93797,-0.37074 -0.0106,-1.74548 -61.02812,0.37127 c -5.87872,1.78133 -4.01289,10.95501 1.05893,11.04876 z"
            />
            <path
              style="fill:#3e035b;fill-opacity:1;stroke:none;stroke-width:0.892396px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 337.29775,214.43003 c 2.23541,9.29272 8.73574,12.80873 16.89792,12.75907 10.15365,-0.0618 16.41225,-12.86079 11.49351,-22.60619 -7.06085,-10.39961 -10.95687,-14.53532 -10.1731,-25.06742 -12.2509,7.49865 -20.65931,24.91416 -18.21833,34.91454 z"
            />
            <path
              style="fill:#48076e;fill-opacity:1;stroke:none;stroke-width:0.79687px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 338.96654,212.64387 c 6.82973,21.66135 35.36551,9.70405 25.1638,-8.85632 -6.2592,-9.35625 -9.71274,-13.0771 -9.0189,-22.55188 0,0 -2.73554,1.54591 -3.34116,2.274 -6.726,6.46383 -15.57104,19.51951 -12.80374,29.1342 z"
            />
            <path
              style="fill:#865a9f;fill-opacity:1;stroke:none;stroke-width:0.72334px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 340.96149,212.42765 c 2.32223,7.44528 7.92795,9.75558 14.47624,9.25935 8.14599,-0.61732 12.44196,-11.39321 7.94034,-19.05741 -6.25813,-8.07753 -9.62015,-11.22901 -9.58956,-19.85251 -10.28035,9.10808 -15.35982,21.59722 -12.82702,29.65057 z"
            />
            <path
              style="fill:#cab1d8;fill-opacity:1;stroke:none;stroke-width:0.617058px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 343.17721,215.60894 c 9.80553,12.78785 24.78505,-2.04896 16.86031,-11.72956 -6.54624,-5.75578 -9.87124,-7.85282 -11.23788,-15.08122 -5.31803,6.32977 -9.90514,17.90275 -5.62243,26.81078 z"
            />
            <path
              style="fill:#e5d3ee;fill-opacity:1;stroke:none;stroke-width:0.452262px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
              d="m 343.97546,214.20553 c 4.95523,10.31287 19.52308,1.19955 13.11215,-7.87678 -4.52952,-4.50562 -6.8674,-6.18953 -7.54145,-11.53903 -4.17562,4.3909 -8.30228,12.70618 -5.5707,19.41581 z"
            />
          </g>
        </g>
      </g>
    </svg>
    """
  end
end
