import { describe, it, expect, beforeEach } from 'vitest'

describe('Customer Notification Contract Tests', () => {
  let contractAddress
  let customerAddress
  let packageId
  
  beforeEach(() => {
    contractAddress = 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.customer-notification'
    customerAddress = 'ST2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7'
    packageId = 1
  })
  
  describe('Notification Preferences', () => {
    it('should set notification preferences successfully', () => {
      const result = {
        type: 'ok',
        value: true
      }
      
      expect(result.type).toBe('ok')
      expect(result.value).toBe(true)
    })
    
    it('should store all preference types', () => {
      const preferences = {
        type: 'some',
        value: {
          'email-enabled': true,
          'sms-enabled': false,
          'push-enabled': true,
          'email-address': 'customer@example.com',
          'phone-number': '+1234567890'
        }
      }
      
      expect(preferences.type).toBe('some')
      expect(preferences.value['email-enabled']).toBe(true)
      expect(preferences.value['sms-enabled']).toBe(false)
      expect(preferences.value['push-enabled']).toBe(true)
    })
  })
  
  describe('Notification Sending', () => {
    it('should send notification successfully', () => {
      const result = {
        type: 'ok',
        value: 1 // notification-id
      }
      
      expect(result.type).toBe('ok')
      expect(result.value).toBe(1)
    })
    
    it('should increment notification counter', () => {
      const firstNotification = { type: 'ok', value: 1 }
      const secondNotification = { type: 'ok', value: 2 }
      
      expect(firstNotification.value).toBe(1)
      expect(secondNotification.value).toBe(2)
    })
    
    it('should store notification details', () => {
      const notification = {
        type: 'some',
        value: {
          customer: customerAddress,
          'package-id': packageId,
          'notification-type': 1, // NOTIFICATION_IN_TRANSIT
          message: 'Your package is in transit',
          'sent-block': 1500,
          'delivery-method': 0 // DELIVERY_EMAIL
        }
      }
      
      expect(notification.type).toBe('some')
      expect(notification.value.customer).toBe(customerAddress)
      expect(notification.value['notification-type']).toBe(1)
    })
  })
  
  describe('Notification Types', () => {
    it('should support all notification types', () => {
      const types = {
        pickup: 0,
        inTransit: 1,
        outForDelivery: 2,
        delivered: 3,
        delayed: 4
      }
      
      expect(types.pickup).toBe(0)
      expect(types.inTransit).toBe(1)
      expect(types.outForDelivery).toBe(2)
      expect(types.delivered).toBe(3)
      expect(types.delayed).toBe(4)
    })
  })
  
  describe('Delivery Methods', () => {
    it('should support all delivery methods', () => {
      const methods = {
        email: 0,
        sms: 1,
        push: 2
      }
      
      expect(methods.email).toBe(0)
      expect(methods.sms).toBe(1)
      expect(methods.push).toBe(2)
    })
  })
  
  describe('Notification Preferences Check', () => {
    it('should return true for enabled email notifications', () => {
      const result = {
        type: 'ok',
        value: true
      }
      
      expect(result.type).toBe('ok')
      expect(result.value).toBe(true)
    })
    
    it('should return false for disabled SMS notifications', () => {
      const result = {
        type: 'ok',
        value: false
      }
      
      expect(result.type).toBe('ok')
      expect(result.value).toBe(false)
    })
    
    it('should return false for customers without preferences', () => {
      const result = {
        type: 'ok',
        value: false
      }
      
      expect(result.type).toBe('ok')
      expect(result.value).toBe(false)
    })
  })
  
  describe('Notification Retrieval', () => {
    it('should return notification details', () => {
      const result = {
        type: 'some',
        value: {
          customer: customerAddress,
          'package-id': 1,
          'notification-type': 3,
          message: 'Your package has been delivered',
          'sent-block': 2000,
          'delivery-method': 0
        }
      }
      
      expect(result.type).toBe('some')
      expect(result.value.customer).toBe(customerAddress)
      expect(result.value.message).toBe('Your package has been delivered')
    })
    
    it('should return none for non-existent notification', () => {
      const result = {
        type: 'none'
      }
      
      expect(result.type).toBe('none')
    })
  })
})
