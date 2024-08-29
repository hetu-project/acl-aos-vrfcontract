# vrf-range-contract

## Public Input
As a public input, the AI network utilizes an RPC request, such as when sending an inference task to the Dispatcher. The HTTPS request includes a JSON parameter as shown below:

```json
{
   "PROMOTE":"WHAT IS AI?",
   "TIMESTAMP":"2024/3/3"  
}
```
The public input employs the hash result of the JSON data structure.

## Sampling Rule on the Chain
The Dispatcher is responsible for determining the rate of each operator that has been selected by the Dispatcher. The sampling rate is stored on-chain.

According to the last 6 bytes of the hash, a value range is established for each operator. Here is an example of the range for operators:

| Operator | Range |
| --- | --- |
| Node 1 | (0, 10) |
| Node 2 | (11, 20) |  
| Node 3 | (21, 30) |
| ... | ... |
| Node 100 | (590000, 600000) |


Based on the value within this range derived from the hash, the corresponding Operator is selected.

Only the dispatcher owner can update the range of Operator.
