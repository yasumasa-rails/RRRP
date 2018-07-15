
const REQUEST = 'REQUEST'
const SUCCESS = 'SUCCESS'
const FAILURE = 'FAILURE'

function createRequestTypes(base) {
  return [REQUEST, SUCCESS, FAILURE].reduce((acc, type) => {
		acc[type] = `${base}_${type}`
		return acc
	}, {})
}

export const LOGIN = createRequestTypes('LOGIN')
export const SIGNIN = createRequestTypes('SIGNIN')
export const STARRED = createRequestTypes('STARRED')
export const STARGAZERS = createRequestTypes('STARGAZERS')

export const UPDATE_ROUTER_STATE = 'UPDATE_ROUTER_STATE'
export const NAVIGATE =  'NAVIGATE'
export const LOAD_USER_PAGE = 'LOAD_USER_PAGE'
export const LOAD_REPO_PAGE = 'LOAD_REPO_PAGE'
export const LOAD_MORE_STARRED = 'LOAD_MORE_STARRED'
export const LOAD_MORE_STARGAZERS = 'LOAD_MORE_STARGAZERS'
export const RESET_ERROR_MESSAGE = 'RESET_ERROR_MESSAGE'


function action(type, payload = {}) {
  return {type, ...payload}
}

export const login = {
  request: login => action(LOGIN[REQUEST], {login}),
  success: (login, response) => action(LOGIN[SUCCESS], {login, response}),
  failure: (login, error) => action(LOGIN[FAILURE], {login, error}),
}

export const signin = {
    request: signin => action(SIGNIN[REQUEST], {signin}),
    success: (signin, response) => action(SIGNIN[SUCCESS], {signin, response}),
    failure: (signin, error) => action(SIGNIN[FAILURE], {signin, error}),
  }
  
export const starred = {
  request: login => action(STARRED[REQUEST], {login}),
  success: (login, response) => action(STARRED[SUCCESS], {login, response}),
  failure: (login, error) => action(STARRED[FAILURE], {login, error}),
}

export const stargazers = {
  request: fullName => action(STARGAZERS[REQUEST], {fullName}),
  success: (fullName, response) => action(STARGAZERS[SUCCESS], {fullName, response}),
  failure: (fullName, error) => action(STARGAZERS[FAILURE], {fullName, error}),
}

export const updateRouterState = state => action(UPDATE_ROUTER_STATE, {state})
export const navigate = pathname => action(NAVIGATE, {pathname})
export const loadUserPage = (login, requiredFields = []) => action(LOAD_USER_PAGE, {login, requiredFields})
export const loadRepoPage = (fullName, requiredFields = []) => action(LOAD_REPO_PAGE, {fullName, requiredFields})
export const loadMoreStarred = login => action(LOAD_MORE_STARRED, {login})
export const loadMoreStargazers = fullName => action(LOAD_MORE_STARGAZERS, {fullName})

export const resetErrorMessage = () => action(RESET_ERROR_MESSAGE)