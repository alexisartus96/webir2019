import React from 'react';
import Footer from './home/components/Footer';
import Header from './home/components/Header';
import global from './home/css/global.css'; // eslint-disable-line
import BackToTop from './home/components/BackToTop';
import Hero from './home/components/Hero';
import Match from "./home/components/Match";
import { Element } from 'react-scroll';

const App = () => (
  <div>
    <Hero />
    <Element id="Match" />
    <Match />
    <BackToTop />
    <Footer />
  </div>
);

export default App;
