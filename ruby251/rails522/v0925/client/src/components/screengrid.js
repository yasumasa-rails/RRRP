import React from 'react';
import { connect } from 'react-redux'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.
const ScreenGrid = ({search}) => (
  search?
  <div>      testtest  </div>
  :"..."
)

function mapStateToProps(state) {
  return { isAuthenticated:state.login.isAuthenticated ,
            menuListData:state.login.menuListData ,
            search:state.screen.search,
            }
}

export default connect(mapStateToProps)(ScreenGrid)
