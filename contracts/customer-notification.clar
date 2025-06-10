;; Customer Notification Contract
;; Manages customer notifications for delivery updates

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_NOTIFICATION_NOT_FOUND (err u401))

;; Notification types
(define-constant NOTIFICATION_PICKUP u0)
(define-constant NOTIFICATION_IN_TRANSIT u1)
(define-constant NOTIFICATION_OUT_FOR_DELIVERY u2)
(define-constant NOTIFICATION_DELIVERED u3)
(define-constant NOTIFICATION_DELAYED u4)

;; Notification preferences
(define-map notification-preferences
  { customer: principal }
  {
    email-enabled: bool,
    sms-enabled: bool,
    push-enabled: bool,
    email-address: (string-ascii 100),
    phone-number: (string-ascii 20)
  }
)

;; Notification history
(define-map notifications
  { notification-id: uint }
  {
    customer: principal,
    package-id: uint,
    notification-type: uint,
    message: (string-ascii 500),
    sent-block: uint,
    delivery-method: uint
  }
)

(define-data-var notification-counter uint u0)

;; Delivery method constants
(define-constant DELIVERY_EMAIL u0)
(define-constant DELIVERY_SMS u1)
(define-constant DELIVERY_PUSH u2)

;; Set notification preferences
(define-public (set-notification-preferences
  (email-enabled bool)
  (sms-enabled bool)
  (push-enabled bool)
  (email-address (string-ascii 100))
  (phone-number (string-ascii 20))
)
  (begin
    (map-set notification-preferences
      { customer: tx-sender }
      {
        email-enabled: email-enabled,
        sms-enabled: sms-enabled,
        push-enabled: push-enabled,
        email-address: email-address,
        phone-number: phone-number
      }
    )
    (ok true)
  )
)

;; Send notification
(define-public (send-notification
  (customer principal)
  (package-id uint)
  (notification-type uint)
  (message (string-ascii 500))
  (delivery-method uint)
)
  (let ((notification-id (+ (var-get notification-counter) u1)))
    (var-set notification-counter notification-id)
    (map-set notifications
      { notification-id: notification-id }
      {
        customer: customer,
        package-id: package-id,
        notification-type: notification-type,
        message: message,
        sent-block: block-height,
        delivery-method: delivery-method
      }
    )
    (ok notification-id)
  )
)

;; Get notification preferences
(define-read-only (get-notification-preferences (customer principal))
  (map-get? notification-preferences { customer: customer })
)

;; Get notification
(define-read-only (get-notification (notification-id uint))
  (map-get? notifications { notification-id: notification-id })
)

;; Check if customer wants specific notification type
(define-read-only (should-notify (customer principal) (delivery-method uint))
  (match (map-get? notification-preferences { customer: customer })
    prefs
    (if (is-eq delivery-method DELIVERY_EMAIL)
      (get email-enabled prefs)
      (if (is-eq delivery-method DELIVERY_SMS)
        (get sms-enabled prefs)
        (if (is-eq delivery-method DELIVERY_PUSH)
          (get push-enabled prefs)
          false
        )
      )
    )
    false
  )
)
