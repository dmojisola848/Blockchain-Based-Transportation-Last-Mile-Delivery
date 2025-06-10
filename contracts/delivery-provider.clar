;; Delivery Provider Verification Contract
;; Manages registration and verification of last-mile delivery providers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_PROVIDER_EXISTS (err u101))
(define-constant ERR_PROVIDER_NOT_FOUND (err u102))
(define-constant ERR_INVALID_STATUS (err u103))

;; Provider status constants
(define-constant STATUS_PENDING u0)
(define-constant STATUS_VERIFIED u1)
(define-constant STATUS_SUSPENDED u2)

;; Data structures
(define-map providers
  { provider-id: principal }
  {
    name: (string-ascii 50),
    contact: (string-ascii 100),
    status: uint,
    registration-block: uint,
    verification-block: (optional uint)
  }
)

(define-map provider-stats
  { provider-id: principal }
  {
    total-deliveries: uint,
    successful-deliveries: uint,
    rating: uint
  }
)

;; Register a new delivery provider
(define-public (register-provider (name (string-ascii 50)) (contact (string-ascii 100)))
  (let ((provider-id tx-sender))
    (asserts! (is-none (map-get? providers { provider-id: provider-id })) ERR_PROVIDER_EXISTS)
    (map-set providers
      { provider-id: provider-id }
      {
        name: name,
        contact: contact,
        status: STATUS_PENDING,
        registration-block: block-height,
        verification-block: none
      }
    )
    (map-set provider-stats
      { provider-id: provider-id }
      {
        total-deliveries: u0,
        successful-deliveries: u0,
        rating: u0
      }
    )
    (ok provider-id)
  )
)

;; Verify a provider (only contract owner)
(define-public (verify-provider (provider-id principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (match (map-get? providers { provider-id: provider-id })
      provider-data
      (begin
        (map-set providers
          { provider-id: provider-id }
          (merge provider-data {
            status: STATUS_VERIFIED,
            verification-block: (some block-height)
          })
        )
        (ok true)
      )
      ERR_PROVIDER_NOT_FOUND
    )
  )
)

;; Get provider information
(define-read-only (get-provider (provider-id principal))
  (map-get? providers { provider-id: provider-id })
)

;; Get provider statistics
(define-read-only (get-provider-stats (provider-id principal))
  (map-get? provider-stats { provider-id: provider-id })
)

;; Check if provider is verified
(define-read-only (is-provider-verified (provider-id principal))
  (match (map-get? providers { provider-id: provider-id })
    provider-data (is-eq (get status provider-data) STATUS_VERIFIED)
    false
  )
)
