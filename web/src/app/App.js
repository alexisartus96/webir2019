import React from 'react';
import Footer from './home/components/Footer';
import Header from './home/components/Header';
import global from './home/css/global.css'; // eslint-disable-line
import BackToTop from './home/components/BackToTop';
import Hero from './home/components/Hero';
import Match from "./home/components/Match";

const App = () => (
  <div>
    <Header />
    <Hero />
    <Match />
    <BackToTop />
    <Footer />
  </div>
);

export default App;
