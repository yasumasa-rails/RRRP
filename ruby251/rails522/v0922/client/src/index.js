import React from 'react';
import ReactDOM from 'react-dom';
import {createStore, applyMiddleware, compose } from "redux";
import { Provider } from 'react-redux';
import createSagaMiddleware from 'redux-saga';
import { BrowserRouter } from 'react-router-dom';
import store from './store';
import registerServiceWorker from './registerServiceWorker';
import rootSaga from './sagas'
import reducer from './reducers'
import App from './components/App';
import 'semantic-ui-css/semantic.min.css';


const sagaMiddleware = createSagaMiddleware();
const store = createStore(reducer, applyMiddleware(sagaMiddleware));
sagaMiddleware.run(rootSaga);


ReactDOM.render(
  <Provider store={store}>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </Provider>,
  document.getElementById('root')
);
registerServiceWorker();
