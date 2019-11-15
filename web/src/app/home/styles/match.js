import styled from 'styled-components';

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: center;
  width: 100%;
  padding-top: 10px;
  padding-bottom: 10px;
  background: #97d885;
`;

export const BetBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 94vw;
  margin-left: 3vw;
  margin-right: 3vw;
  border-radius: 30px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.3);
`;

export const BetOptionsBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 10%;
`;

export const RowBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 100%;
    
  &:nth-child(even) {
    background-color: #CAD3C8;
  }

  &:nth-child(odd) {
    background-color: white;
  }

  &:first-child {
    background-color: #2C3A47;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
  }

  &:last-child {
    background-color: #2C3A47;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  }
`;

export const MatchBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 50%;
  padding: 10px;
`;

export const ClubBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 45%;
  text-align: center;
`;

export const ClubName = styled.h4`
  padding: 5px;
`;

export const BoxTitle = styled.h4`
  font-size: 20px;
  font-weight: bold;
  color: white;
`;

export const BetButton = styled.a`
  cursor: pointer;
  padding: 12px 12px;
  display: inline-block;
  margin: 2px 5px;
  font-weight: 700;
  background: #4cd16e;
  color: #fff;
  border-radius: 7px;
  box-shadow: 0 5px #42ab5b;
  text-align: center;
  min-width: 20px;
  width: 100%;
`;

export const ChoiceBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 50%;
`;

export const BasicDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 100%;
`;

export const BasicDivSupermatch = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 50%;
  border-left: 2px solid #000;
  border-right: 2px solid #000;
`;

export const SupermatchResultBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50%;
  text-align: center;
  border-right: 2px solid #000;
  border-left: 2px solid #000;
  padding: 10px;
`;

export const BasicDivBet365 = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 50%;
`;

export const Bet365ResultBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50%;
  text-align: center;
  padding: 10px;
`;

export const DividendBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 33%;
  text-align: center;
`;
