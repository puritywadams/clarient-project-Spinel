;; clear-donate
;; A simple contract for transparent donations.

;; ---
;; Constants
;; ---
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u101))

;; ---
;; Data Maps and Variables
;; ---
(define-data-var total-donations uint u0)
(define-map donations principal uint)

;; ---
;; Public Functions
;; ---

;; @desc Allows anyone to donate STX to the contract.
;; @param amount The amount of micro-STX to donate.
;; @post The sender's STX is transferred to the contract.
;; @post The total donation amount is increased.
;; @post The sender's donation amount in the `donations` map is updated.
(define-public (donate (amount uint))
  (begin
    ;; Attempt to transfer STX from the sender to this contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))

    ;; On successful transfer, update the state
    (var-set total-donations (+ (var-get total-donations) amount))
    (map-set donations tx-sender (+ (default-to u0 (map-get? donations tx-sender)) amount))

    (ok true)
  )
)

;; @desc Allows the contract owner to withdraw the entire balance.
;; @post The entire STX balance of the contract is transferred to the contract owner.
(define-public (withdraw)
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_NOT_AUTHORIZED)
    (let ((balance (stx-get-balance (as-contract tx-sender))))
      (if (> balance u0)
        (as-contract (stx-transfer? balance (as-contract tx-sender) CONTRACT_OWNER))
        (ok true)
      )
    )
  )
)

;; ---
;; Read-Only Functions
;; ---

;; @desc Gets the total amount of STX donated to the contract.
(define-read-only (get-total-donations)
  (var-get total-donations)
)

;; @desc Gets the total amount donated by a specific principal.
(define-read-only (get-donation-amount (who principal))
  (default-to u0 (map-get? donations who))
)