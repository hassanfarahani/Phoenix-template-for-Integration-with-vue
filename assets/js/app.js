// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"
import * as d3 from 'd3';

let Hooks = {}

Hooks.repaint = {
  mounted() {
    processData();
  },
  updated() {
    processData();
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

liveSocket.connect()

window.liveSocket = liveSocket

function processData(){
  let properties = extract();
  repaint(properties);
}

function extract(){
  let properties = [];
  let inputs = Array.from(document.querySelectorAll("input[type=range]"));

  inputs.forEach(
    function(currentValue){
      let names = currentValue.name.match(/\[(.*)?\]/);
      let obj = {
        name: names[1],
        value: parseFloat(currentValue.value)
      }
      properties.push(obj);
    }
  );
  return properties;
}

function repaint(properties) {
  process_data(properties);

  let posx = 25
  var svg = d3.select("#samplediv")
  properties.forEach(function(item){
    svg.append("circle").attr("cx", posx).attr("cy", 25).attr("r", item.value*10).style("fill", "blue");
    posx+=150;
  })
}

function process_data(properties) {
  // Create an array with the values to be plot

}

