/* eslint-disable no-restricted-syntax */
/* eslint-disable react/jsx-one-expression-per-line */
import React from 'react';
import {
  OuterDiv,
  BetBox,
  MatchBox,
  ClubBox,
  ClubName,
  BetButton,
  ChoiceBox,
  BetOptionsBox,
  SupermatchResultBox,
  Bet365ResultBox,
  BoxTitle,
  DividendBox,
  BasicDiv,
  BasicDivSupermatch,
  BasicDivBet365,
  RowBox,
} from '../styles/match';
import matches from './test';
import axios from 'axios';

class Match extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      matches: [],
      selectedMatches: [],
      scores: [],
      supermatchFinalScore: 1,
      bet365FinalScore: 1,
    };

    this.optionClicked = this.optionClicked.bind(this);
    this.updateScores = this.updateScores.bind(this);
  }

  componentWillMount() {
    /*matches.map((value, index) => {
      value.selected = [];
      value.selected[1] = false;
      value.selected[2] = false;
      value.selected[3] = false;
      return false;
    });*/
  }

  componentDidMount() {
    this.getMatches();
  }

  optionClicked(option, index) {
    const { matches, selectedMatches } = this.state;
    let auxSelectedMatches = selectedMatches;
    const match = matches[index];
    if (!auxSelectedMatches.includes(match)) {
      match.selected[option] = true;
      auxSelectedMatches.push(match);
    } else if (match.selected[option]) {
      match.selected[option] = false;
      auxSelectedMatches = auxSelectedMatches.filter((item, j) => item !== match);
    } else {
      match.selected[1] = false;
      match.selected[2] = false;
      match.selected[3] = false;
      match.selected[option] = true;
    }
    this.updateScores(auxSelectedMatches);
  }

  getMatches() {
    axios.get(process.env.REACT_APP_API_MATCHES)
      .then(({ data }) => {
        data.map((value, index) => {
          value.selected = [];
          value.selected[1] = false;
          value.selected[2] = false;
          value.selected[3] = false;
          return false;
        });
        this.setState(
          {
            matches: data,
          },
        );
      })
      .catch((error) => {
        console.log(error);
        if (error.response) { // If a response has been received from the server
          console.log(error.response.data);
          console.log(error.response.status);
          console.log(error.response.headers);
        }
      });
  } 

  updateScores(matches) {
    let auxSupermatchFinalScore = 1;
    let auxBet365FinalScore = 1;
    const auxScores = [];
    for (const [index, value] of matches.entries()) {
      const result = {};
      result.bet365 = value.selected[1]
        ? value.dividendoLocalBet
        : value.selected[2]
          ? value.dividendoEmpateBet
          : value.dividendoVisitanteBet;
      result.supermatch = value.selected[1]
        ? value.dividendoLocalSM
        : value.selected[2]
          ? value.dividendoEmpateSM
          : value.dividendoVisitanteSM;
      result.result = value.selected[1]
        ? 'Gana Local'
        : value.selected[2]
          ? 'Empate'
          : 'Gana Visitante';
      auxSupermatchFinalScore *= result.supermatch;
      auxSupermatchFinalScore = auxSupermatchFinalScore.toFixed(2);
      auxBet365FinalScore *= result.bet365;
      auxBet365FinalScore = auxBet365FinalScore.toFixed(2);
      auxScores.push(result);
    }
    this.setState({
      selectedMatches: matches,
      scores: auxScores,
      supermatchFinalScore: auxSupermatchFinalScore,
      bet365FinalScore: auxBet365FinalScore,
    });
  }

  render() {
    const btnStyle = {
      background: 'red',
      'box-shadow': '0 5px red',
    };
    const topBorderStyle = {
      'border-top': 'medium solid black',
    };
    const rightBorderStyle = {
      'border-right': 'medium solid black',
    };
    const topRightBorderStyle = {
      'border-top': 'medium solid black',
      'border-right': 'medium solid black',
    };
    const topRightBorderRadiusStyle = {
      'border-radius': '0 12px 0 0',
    };
    const bottomRightBorderRadiusStyle = {
      'border-radius': '0 0 12px 0',
    };
    const selectedStyle = {
      border: '2px dotted black',
      'border-radius': '5px',
    };
    const unSelectedStyle = {
      border: '2px dotted rgba(255, 0, 0, 0)',
      'border-radius': '5px',
    };
    const {
      matches, scores, supermatchFinalScore, bet365FinalScore,
    } = this.state;
    return (
      <OuterDiv>
        <BetBox>
          <RowBox>
            <BasicDiv style={rightBorderStyle}>
              <BoxTitle>PARTIDOS</BoxTitle>
            </BasicDiv>
            <BasicDiv>
              <BasicDivSupermatch>
                <BoxTitle>SUPERMATCH</BoxTitle>
              </BasicDivSupermatch>
              <BasicDivBet365 style={topRightBorderRadiusStyle}>
                <BoxTitle>BET365</BoxTitle>
              </BasicDivBet365>
            </BasicDiv>
          </RowBox>
          {matches.map((value, index) => (
            <RowBox>
              <MatchBox id={index} style={rightBorderStyle}>
                <ClubBox>
                  <ClubName>{value.local}</ClubName>
                </ClubBox>
                <BetOptionsBox>
                  <BetButton
                    style={value.selected[1] ? btnStyle : {}}
                    onClick={() => this.optionClicked(1, index)}
                  >
                    Gana 1
                  </BetButton>
                  <BetButton
                    style={value.selected[2] ? btnStyle : {}}
                    onClick={() => this.optionClicked(2, index)}
                  >
                    Empate
                  </BetButton>
                  <BetButton
                    style={value.selected[3] ? btnStyle : {}}
                    onClick={() => this.optionClicked(3, index)}
                  >
                    Gana 2
                  </BetButton>
                </BetOptionsBox>
                <ClubBox>
                  <ClubName>{value.visitante}</ClubName>
                </ClubBox>
              </MatchBox>
              <ChoiceBox id={index}>
                <SupermatchResultBox>
                  <DividendBox>
                    <ClubName style={value.selected[1] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoLocalSM}
                    </ClubName>
                  </DividendBox>
                  <DividendBox>
                    <ClubName style={value.selected[2] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoEmpateSM}
                    </ClubName>
                  </DividendBox>
                  <DividendBox>
                    <ClubName style={value.selected[3] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoVisitanteSM}
                    </ClubName>
                  </DividendBox>
                </SupermatchResultBox>
                <Bet365ResultBox>
                  <DividendBox>
                    <ClubName style={value.selected[1] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoLocalBet}
                    </ClubName>
                  </DividendBox>
                  <DividendBox>
                    <ClubName style={value.selected[2] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoEmpateBet}
                    </ClubName>
                  </DividendBox>
                  <DividendBox>
                    <ClubName style={value.selected[3] ? selectedStyle : unSelectedStyle}>
                      {value.dividendoVisitanteBet}
                    </ClubName>
                  </DividendBox>
                </Bet365ResultBox>
              </ChoiceBox>
            </RowBox>
          ))}
          <RowBox>
            <BasicDiv style={topRightBorderStyle}>
              <BoxTitle>TOTAL:</BoxTitle>
            </BasicDiv>
            <BasicDiv style={topBorderStyle}>
              <BasicDivSupermatch>
                <BoxTitle>{supermatchFinalScore}</BoxTitle>
              </BasicDivSupermatch>
              <BasicDivBet365 style={bottomRightBorderRadiusStyle}>
                <BoxTitle>{bet365FinalScore}</BoxTitle>
              </BasicDivBet365>
            </BasicDiv>
          </RowBox>
        </BetBox>
      </OuterDiv>
    );
  }
}

export default Match;
