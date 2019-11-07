import React from 'react';
import {
  OuterDiv, BetBox, MatchBox, ClubBox, ClubName, BetOptionBox, BetButton, BetScoreBox, 
  ChoiceBox, BetOptionsBox, MatchChoiceBox, SupermatchResultBox, Bet365ResultBox,
} from '../styles/match';
import matches from './test';

class Match extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      matches,
      selectedMatches: [],
      scores: [],
      supermatchFinalScore: 0,
      bet365FinalScore: 0,
    };

    this.optionClicked = this.optionClicked.bind(this);
    this.updateScores = this.updateScores.bind(this);
  }


  componentWillMount() {
    matches.map((value, index) => {
      value.selected = [];
      value.selected[1] = false;
      value.selected[2] = false;
      value.selected[3] = false;
      return false;
    });
  }

  componentDidMount() {
  }

  optionClicked(option, index) {
    const { matches, selectedMatches } = this.state;
    var auxSelectedMatches = selectedMatches;
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

  updateScores(matches) {
    var auxSupermatchFinalScore = 1;
    var auxBet365FinalScore = 1;
    var auxScores = [];
    for (const [index, value] of matches.entries()) {
      let result = {};
      result.bet365 = value.selected[1] ? value.dividendos.bet365.ganaLocal : (value.selected[2] ? value.dividendos.bet365.empate : value.dividendos.bet365.ganaVisitante);
      result.supermatch = value.selected[1] ? value.dividendos.supermatch.ganaLocal : (value.selected[2] ? value.dividendos.supermatch.empate : value.dividendos.supermatch.ganaVisitante);
      result.result = value.selected[1] ? 'Gana Local' : (value.selected[2] ? 'Empate' : 'Gana Visitante');
      auxSupermatchFinalScore *= result.supermatch;
      auxSupermatchFinalScore = auxSupermatchFinalScore.toFixed(2);
      auxBet365FinalScore *= result.bet365;
      auxBet365FinalScore = auxBet365FinalScore.toFixed(2);
      auxScores.push(result)
    }
    this.setState({
      selectedMatches: matches,
      scores : auxScores,
      supermatchFinalScore : auxSupermatchFinalScore,
      bet365FinalScore : auxBet365FinalScore
    });
  }

  render() {
    var btnStyle = {
      background: 'red',
      'box-shadow': '0 5px red'
    };
    const { matches, scores, supermatchFinalScore, bet365FinalScore
    } = this.state;
    return (
      <OuterDiv>
        <BetBox>
          {matches.map((value, index) => {
              return (<MatchBox id={index}>
                        <ClubBox>
                          <ClubName>{value.local}</ClubName>
                        </ClubBox>
                        <BetOptionsBox>
                          <BetButton style={value.selected[1] ? btnStyle : {}} onClick={() => this.optionClicked(1, index)}>Gana 1</BetButton>
                          <BetButton style={value.selected[2] ? btnStyle : {}} onClick={() => this.optionClicked(2, index)}>Empate</BetButton>
                          <BetButton style={value.selected[3] ? btnStyle : {}} onClick={() => this.optionClicked(3, index)}>Gana 2</BetButton>
                        </BetOptionsBox>
                        <ClubBox>
                          <ClubName>{value.visitante}</ClubName>
                        </ClubBox>
                      </MatchBox>)
            }
          )}
        </BetBox>
        <BetScoreBox>
          <ChoiceBox>
            <MatchChoiceBox />
            <SupermatchResultBox>
              <ClubName>Supermatch</ClubName>
            </SupermatchResultBox>
            <Bet365ResultBox>
              <ClubName>Bet365</ClubName>
            </Bet365ResultBox>
          </ChoiceBox>
            {scores.map((value, index) => {
              return (<ChoiceBox id={index}>
                        <MatchChoiceBox>
                          <ClubName>Resultado: {value.result}</ClubName>
                        </MatchChoiceBox>
                        <SupermatchResultBox>
                          <ClubName>{value.supermatch}</ClubName>
                        </SupermatchResultBox>
                        <Bet365ResultBox>
                          <ClubName>{value.bet365}</ClubName>
                        </Bet365ResultBox>
                      </ChoiceBox>)
            }
            )}
            <ChoiceBox>
            <MatchChoiceBox />
            <SupermatchResultBox>
              <ClubName>Total: {supermatchFinalScore}</ClubName>
            </SupermatchResultBox>
            <Bet365ResultBox>
              <ClubName>Total: {bet365FinalScore}</ClubName>
            </Bet365ResultBox>
          </ChoiceBox>
        </BetScoreBox>
      </OuterDiv>
    );
  }
}

export default Match;
