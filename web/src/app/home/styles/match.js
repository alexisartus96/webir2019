import styled from 'styled-components';

export const OuterDiv = styled.div`
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    width: 90%;
    padding: 20px;
`;
export const BetBox = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 40vw;
`;

export const MatchBox = styled.div`
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    width: 100%;
`;

export const ClubName = styled.h4`
`;

export const BetButton = styled.a`
    cursor: pointer;
    padding: 15px 15px;
    display: inline-block;
    margin: 10px 10px;
    font-weight: 700;
    background: #17aa56;
    color: #fff;
    border-radius: 7px;
    box-shadow: 0 5px #119e4d;
`;

export const BetScoreBox = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 40vw;
`;