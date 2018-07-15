import React from 'react';
import {withAuth} from 'react-devise';

const Home = ({auth: {AuthLinks}}) => {
  return (
    <div>
      <AuthLinks />
    </div>
  );
};

export default withAuth(Home);