# Clear-Donate: A Transparent Donation Platform on Stacks

This project provides a simple, transparent, and secure way to handle donations using a Clarity smart contract on the Stacks blockchain. It aims to solve the problem of opacity in charitable giving by making all transactions publicly verifiable.

## How it Works

The core of the project is the `clear-donate.clar` smart contract.

*   **Anyone can donate:** Users can call the `donate` function to send STX to the contract.
*   **Public Ledger:** Every donation is recorded on the blockchain, creating an immutable and transparent history of contributions.
*   **Secure Withdrawals:** Only the designated owner of the contract (the deployer) can withdraw the collected funds.
*   **Full Transparency:** Anyone can call read-only functions to see the total amount donated and the contribution from any specific address.

## Getting Started

1.  **Check the contract:**
    ```sh
    clarinet check
    ```
2.  **Run the tests:**
    ```sh
    npm test
    ```
