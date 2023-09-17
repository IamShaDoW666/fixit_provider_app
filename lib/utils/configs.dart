import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

const APP_NAME = 'Fixit Services';
const DEFAULT_LANGUAGE = 'en';

const primaryColor = Color.fromARGB(255, 181, 93, 31);
const DOMAIN_URL =
    'https://yallakhedma.com'; // Don't add slash at the end of the url
const BASE_URL = "$DOMAIN_URL/api/";

/// You can specify in Admin Panel, These will be used if you don't specify in Admin Panel
const IOS_LINK_FOR_PARTNER =
    "https://apps.apple.com/in/app/handyman-provider-app/id1596025324";

const TERMS_CONDITION_URL = 'https://yallakhedma.com';
const PRIVACY_POLICY_URL = 'https://yallakhedma.com';
const INQUIRY_SUPPORT_EMAIL = 'info@yallakhedma.com';

const GOOGLE_MAPS_API_KEY = 'Ert6pyCHJwjZjGSOBc18-3mJM8tRtIpoV3No8l1';

const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';

DateTime todayDate = DateTime(2022, 8, 24);

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";

Country defaultCountry() {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+919123456789',
  );
}
