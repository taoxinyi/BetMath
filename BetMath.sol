pragma solidity ^0.4.24;


/**
 * @title BetMath
 * @dev Library for distribute bonus fairly for N closest bet of future event.
 */

library BetMath {
    /**
    * @dev Get proportion weight for outcomes. Return the proportion weight of each outcome
    * @param count uint256 The count of winning situation
    * @param difficulty uint8 The difficulty of guessing exact the right answer
    * @param precision uint256 the precision used and returned for calculation
    * @return proportionList uint256[] The proportion weight of each outcome multiplied by precision
    */
    function getProportionList(
        uint256 count,
        uint8 difficulty,
        uint256 precision
    )
    public
    pure
    returns (uint256[] proportions)
    {
        uint256[] memory proportions_ = new uint256[](count);
        uint256 piece = precision / count;
        uint256 firstBlock = precision ** difficulty - (precision - piece) ** difficulty;
        uint256 rate;
        proportions_[0] = precision;
        for (uint8 i = 1; i < count; i++) {
            rate = i * precision / count;
            proportions_[i] = ((precision - rate) ** difficulty - (precision - rate - piece) ** difficulty) * precision / firstBlock;
        }
        return proportions_;
    }

    /**
    * @dev get winning rate for outcomes. Return the list of it
    * @param costs uint256[] The list of how much most each outcome(which can be redeemed) is placed
    * @param remaining The amount that can be divided for except the principal of winners
    * @param difficulty uint8 The difficulty of guessing exact the right answer
    * @param precision uint256 the precision used and returned for calculation
    * @return winning rate of each outcome based on the principal and remaining
    */
    function getWinningRate(
        uint256[] costs,
        uint256 remaining,
        uint8 difficulty,
        uint256 precision
    )
    public
    pure
    returns (uint256[] winningRates)
    {
        uint256 count = costs.length;
        uint256 base = 0;
        uint256[] memory proportions = getProportionList(count, difficulty, precision);
        for (uint8 i = 0; i < count; i++)
            base += proportions[i] * costs[i];
        uint256 rate = remaining * precision ** 2 / base;
        for (i = 0; i < count; i++)
            proportions[i] = proportions[i] * rate / precision;
        return proportions;

    }

    /**
    * @dev get winning rate for outcomes. Return the list of it
    * @param costs uint256[] The list of how much most each outcome(which can be redeemed) is placed
    * @param remaining The amount that can be divided for except the principal of winners
    * @param difficulty uint8 The difficulty of guessing exact the right answer
    * @param precision uint256 the precision used and returned for calculation
    * @return winning rate of each outcome based on the principal and remaining
    */
    function redeemWinnings(
        uint256[] costs,
        uint256 remaining,
        uint8 difficulty,
        uint256 precision
    )
    public
    pure
    returns (uint256[] winnings)
    {
        uint256 count = costs.length;
        uint256[] memory winningRates = getWinningRate(costs, remaining, difficulty, precision);
        uint256[] memory bonus = new uint256[](count);
        for (uint8 i = 0; i < count; i++)
            bonus[i] = costs[i] * winningRates[i] / precision;
        return bonus;
    }
}