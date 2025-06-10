# Blockchain-Based Transportation Last-Mile Delivery System

A comprehensive blockchain solution for managing last-mile delivery operations using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized platform for managing delivery providers, optimizing routes, tracking packages, notifying customers, and measuring performance in last-mile delivery operations.

## Smart Contracts

### 1. Delivery Provider Verification (`delivery-provider.clar`)
- **Purpose**: Manages registration and verification of delivery providers
- **Key Features**:
    - Provider registration with contact information
    - Verification system (admin-controlled)
    - Provider status tracking (pending, verified, suspended)
    - Performance statistics tracking

### 2. Route Optimization (`route-optimization.clar`)
- **Purpose**: Manages delivery routes and optimization
- **Key Features**:
    - Route creation with waypoints and estimates
    - Route execution tracking
    - Performance data collection (actual vs estimated)
    - Route status management

### 3. Package Tracking (`package-tracking.clar`)
- **Purpose**: Comprehensive package tracking throughout delivery lifecycle
- **Key Features**:
    - Package creation and assignment
    - Real-time status updates
    - Event logging with timestamps
    - Route assignment integration

### 4. Customer Notification (`customer-notification.clar`)
- **Purpose**: Manages customer notifications for delivery updates
- **Key Features**:
    - Notification preference management
    - Multi-channel delivery (email, SMS, push)
    - Notification history tracking
    - Automated notification triggers

### 5. Performance Measurement (`performance-measurement.clar`)
- **Purpose**: Tracks and analyzes delivery performance metrics
- **Key Features**:
    - Provider performance tracking
    - On-time delivery rate calculation
    - Customer rating system
    - Period-based performance analysis

## System Architecture

\`\`\`
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Delivery      │    │      Route      │    │    Package      │
│   Provider      │◄──►│  Optimization   │◄──►│   Tracking      │
│  Verification   │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
│                       │                       │
│                       │                       │
▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Customer      │    │  Performance    │    │   Blockchain    │
│ Notification    │◄──►│  Measurement    │◄──►│   Network       │
│                 │    │                 │    │   (Stacks)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
\`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain node
- Clarity CLI tools
- Node.js and npm (for testing)

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd blockchain-delivery-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks blockchain:

\`\`\`bash
# Deploy delivery provider contract
clarinet deploy contracts/delivery-provider.clar

# Deploy route optimization contract
clarinet deploy contracts/route-optimization.clar

# Deploy package tracking contract
clarinet deploy contracts/package-tracking.clar

# Deploy customer notification contract
clarinet deploy contracts/customer-notification.clar

# Deploy performance measurement contract
clarinet deploy contracts/performance-measurement.clar
\`\`\`

## Usage Examples

### Register a Delivery Provider

\`\`\`clarity
(contract-call? .delivery-provider register-provider "FastDelivery Co" "contact@fastdelivery.com")
\`\`\`

### Create a Package

\`\`\`clarity
(contract-call? .package-tracking create-package
'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7
'SP1HTBVD3JG9C05J7HBJTHGR0GGW7KX975CN9RXER
"123 Pickup St, City"
"456 Delivery Ave, Town"
0x1234567890abcdef)
\`\`\`

### Track Package Status

\`\`\`clarity
(contract-call? .package-tracking get-package u1)
\`\`\`

## API Reference

### Delivery Provider Contract

- `register-provider(name, contact)` - Register new provider
- `verify-provider(provider-id)` - Verify provider (admin only)
- `get-provider(provider-id)` - Get provider information
- `is-provider-verified(provider-id)` - Check verification status

### Route Optimization Contract

- `create-route(provider-id, start, end, waypoints, time, distance)` - Create route
- `start-route(route-id)` - Start route execution
- `complete-route(route-id, actual-time, actual-distance, fuel)` - Complete route
- `get-route(route-id)` - Get route information

### Package Tracking Contract

- `create-package(recipient, provider, pickup, delivery, hash)` - Create package
- `update-package-status(package-id, status, location, notes)` - Update status
- `assign-to-route(package-id, route-id)` - Assign to route
- `get-package(package-id)` - Get package information

### Customer Notification Contract

- `set-notification-preferences(email, sms, push, email-addr, phone)` - Set preferences
- `send-notification(customer, package-id, type, message, method)` - Send notification
- `get-notification-preferences(customer)` - Get preferences

### Performance Measurement Contract

- `record-delivery-performance(package-id, provider, est-time, actual-time, rating)` - Record performance
- `get-provider-performance(provider-id)` - Get performance metrics
- `get-on-time-rate(provider-id)` - Get on-time delivery rate

## Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Test files are located in the `tests/` directory and cover:
- Contract deployment
- Function calls and responses
- Error handling
- Integration scenarios

## Security Considerations

- **Access Control**: Provider-specific functions require proper authorization
- **Data Validation**: Input validation for all contract functions
- **State Management**: Proper state transitions and consistency checks
- **Privacy**: Sensitive customer data should be handled off-chain

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## Roadmap

- [ ] Integration with real-world GPS tracking
- [ ] Mobile app development
- [ ] Advanced analytics dashboard
- [ ] Multi-chain support
- [ ] IoT device integration
  \`\`\`

Let's create the PR details file:


