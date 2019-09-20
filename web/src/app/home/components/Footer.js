import React from 'react';
import {
  Box, FooterText, SubBox
} from '../styles/footer';

const today = new Date();

const Footer = () => (
  <Box>
    <SubBox shrink>
      <FooterText>
        {'\u00A9 Webir, '}
        {today.getFullYear()}
      </FooterText>
    </SubBox>
    <SubBox>
    </SubBox>
    <SubBox dontShowOnTablet>
    </SubBox>
    <SubBox>
    </SubBox>
  </Box>);

export default Footer;
