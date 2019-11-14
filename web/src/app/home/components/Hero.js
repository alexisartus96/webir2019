import React from 'react';
import {
  scroller as scroll,
} from 'react-scroll';
import heroImage from '../assets/hero.jpg';
import arrowDown from '../assets/flecha.png';
import {
  HeroImage, HeroTitle, TextBox, PrimaryBox, GoTo, Br, HeroSubTitle, SubTextBox, GoToLink,
} from '../styles/hero';

const Hero = () => (
  <PrimaryBox>
    <HeroImage src={heroImage} />
    <TextBox>
      <HeroTitle>
         Bienvenido al nuevo mundo de las
        <Br />
          apuestas deportivas
      </HeroTitle>
    </TextBox>
    <HeroSubTitle>
      <SubTextBox>
          Empieza a jugar
      </SubTextBox>
    </HeroSubTitle>
    <GoToLink onClick={() => scroll.scrollTo('Match', {
      delay: 0, smooth: 'easeInOutQuart', duration: 1000, offset: (0),
    })}
    >
      <GoTo src={arrowDown} />
    </GoToLink>
  </PrimaryBox>
);

export default Hero;
