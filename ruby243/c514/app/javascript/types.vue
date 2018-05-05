import Vue from 'vue/dist/vue.esm'
import { StyleFactory } from  '@hscmap/vue-menu/lib/types/style.d.ts'
const active = {
    backgroundColor: '#436f7c'
}
const disabled = {
    opacity: '0.5'
}
const separator = {
    backgroundColor: 'rgba(255, 0, 0, 0.5)'
}
export default <any>{
    components: {
        'my-theme': StyleFactory({
            menu: {
                background: 'linear-gradient(to bottom, rgba(0, 0, 0, 0.25), #436f7c)',
                color: 'white',
                boxShadow: '0 2pt 4pt rgba(0, 0, 0, 0.5)'
            },
            menubar: {
                background: 'linear-gradient(to bottom, rgba(0, 0, 0, 0.25), #436f7c)',
                color: 'white',
                boxShadow: '0 4pt 4pt rgba(0, 0, 0, 0.25)'
            },
            active,
            disabled,
            separator
        })
    }
}