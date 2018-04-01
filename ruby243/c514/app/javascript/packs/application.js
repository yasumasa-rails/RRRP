/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
// import Menu from '../menu.vue'
import Vue from 'vue/dist/vue.esm'
import  local from '@hscmap/vue-menu/standalone/dist/vue-menu-standalone.js'
import * as  VueMenu from '@hscmap/vue-menu/lib/index.js'
// import { StyleFactory } from  '../types.vue'
Vue.use(VueMenu,{local})

window.addEventListener('load', e => {
  new Vue({
      el: '#root',
      data: {
          checked: true,
          alert: function (msg) { window.alert(msg); }
      }    
  })
})
