import styled from 'styled-components';

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: center;
  width: 100%;
  padding-top: 30px;
  padding-bottom: 30px;
  background: #97d885;
`;

export const BetBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 45vw;
  border-radius: 15px;
  background: #f3ec5a;
  border: medium solid black;
`;

export const MatchBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 100%;
  padding: 15px;
`;

export const ClubBox = styled.div`
  width: 32%;
  text-align: center;
`;

export const ClubName = styled.h4``;

export const BetOptionsBox = styled.div`
  width: 34%;
`;

export const BetButton = styled.a`
  cursor: pointer;
  padding: 12px 12px;
  display: inline-block;
  margin: 2px 2px;
  font-weight: 700;
  background: #17aa56;
  color: #fff;
  border-radius: 7px;
  box-shadow: 0 5px #119e4d;
  text-align: center;
`;

export const BetScoreBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 45vw;
  background: #f7b5b1;
  border-radius: 15px;
  border: medium solid black;
`;

export const ChoiceBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 100%;
`;

export const MatchChoiceBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50%;
  text-align: left;
`;

export const SupermatchResultBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 25%;
  text-align: center;
  background: #ff4a41;
`;

export const Bet365ResultBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 25%;
  text-align: center;
  background: #17aa56;
`;
