# BetMath
## Introduction

Sometimes events can have multiple outcomes, which can be demonstrated by grades or scores.

For example, to anticipate the quality or satisfaction of a product,the outcome is usually demonstrated by score like 1-100 or 1-10;

In this case, whoever bet the exact score revealed in the future will of course receive the highest reward.However, sometimes we need to encourage more bets by rewarding whoever bet close to the actual result.

Let's say the reward range is 10% and each outcome has equal possibility to happen.

If the final outcome is `7` in the range of `1-10`, those who bet from `6-8` can receive the reward. But those who bet `7` should have the largest rate of return.

If the final outcome is `70` in the range of `1-100`, those who bet from `60-80` can receive the reward. But those who bet `70` should have the largest rate of return. Those who bet `69` or `71` should have second largest rate of return,...

It's fairly reasonable that if the count of the result is larger, it's much more difficult to guess near the final result.`("guessing 69 to 70 in 100 results is more difficult than guessing 6 to 7 in 10 results, so it deserves more rewarding")`

Therefore, the rate of return (the money won per cost) should obey the following rules:

- The closer the bet is, the larger the rate is.
- The larger the total number is, the closer the rate is compared to the rate of return of exact outcome.
- The weight function should be convex function in order to ensure whoever bet the right outcome gets relatively higher rate.

## Implementation

let function  `w(x)=(n+1)(1-x)^n (0<=x<=1, n∈N+)`

function `W(n)=w(x)dx from n/N to (n+1)/N` should be the weight function

For example, if the result is 5 and 6,7 can be accepted as well, so there are 3 grades of outcomes can be accepted. Sothe weight is the square of three piece, which is `w(x)dx from 0 to 1/3`,`w(x)dx from 1/3 to 2/3` and `w(x)dx from 2/3 to 1`,

if n=3, the result is `0.8, 0.18, 0.02`, and divide `0.8` we get the proportion list `[1.0, 0.23, 0.015]`

Finally, if the amount of 5,6,7 is 100,200,300 and the bonus pool is 1000. Then only need to caculate winning rate k

`k(100+200*0.23+300*0.15)=1000`

After solve `k=6.63`  we can easily know how we should distribute the bonus:

`[663.3, 306.1, 30.6]`