type entityName =
  | CONNECTOR
  | ROUTING
  | MERCHANT_ACCOUNT
  | PAYMENT
  | REFUNDS
  | DISPUTES
  | ANALYTICS_PAYMENTS
  | ANALYTICS_USER_JOURNEY
  | ANALYTICS_REFUNDS
  | SETTINGS
  | ONBOARDING
  | API_KEYS
  | ORDERS
  | DEFAULT_FALLBACK
  | CHANGE_PASSWORD
  | ANALYTICS_SYSTEM_METRICS
  | PAYMENT_LOGS
  | SDK_EVENT_LOGS
  | WEBHOOKS_EVENT_LOGS
  | CONNECTOR_EVENT_LOGS
  | GENERATE_SAMPLE_DATA
  | USERS
  | RECON
  | INTEGRATION_DETAILS
  | FRAUD_RISK_MANAGEMENT
  | USER_MANAGEMENT
  | TEST_LIVE_PAYMENT
  | THREE_DS
  | BUSINESS_PROFILE
  | VERIFY_APPLE_PAY
  | PAYMENT_REPORT
  | REFUND_REPORT
  | DISPUTE_REPORT
  | PAYPAL_ONBOARDING
  | SURCHARGE
  | CUSTOMERS
  | ACCEPT_DISPUTE
  | DISPUTES_ATTACH_EVIDENCE

type userRoleTypes = USER_LIST | ROLE_LIST | ROLE_ID | NONE

type reconType = [#TOKEN | #REQUEST | #NONE]

type userType = [
  | #CONNECT_ACCOUNT
  | #SIGNUP
  | #SIGNIN
  | #SIGNINV2
  | #SIGNOUT
  | #FORGOT_PASSWORD
  | #RESET_PASSWORD
  | #VERIFY_EMAIL_REQUEST
  | #VERIFY_EMAIL
  | #VERIFY_EMAILV2
  | #SET_METADATA
  | #SWITCH_MERCHANT
  | #PERMISSION_INFO
  | #MERCHANT_DATA
  | #USER_DATA
  | #INVITE
  | #INVITE_MULTIPLE
  | #RESEND_INVITE
  | #CREATE_MERCHANT
  | #ACCEPT_INVITE
  | #GET_PERMISSIONS
  | #NONE
]
