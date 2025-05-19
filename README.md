# xccovPretty

`xccovPretty` is a command-line tool for making Xcode’s `xccov` code coverage output prettier. While
`xccov` can produce human-readable output, line lengths can be pretty long, and directory
hierarchies aren’t clearly displayed. `xccovPretty` uses `xccov`’s JSON output to produce a more
readable version.


## How to Run

`xccovPretty` is implemented as a Swift Package, so you can run it using standard Swift tools:

    swift run xccovPretty.

## Usage

To use `xccovPretty`, just pipe the output of `xccov view --report «PATH» --json` to `xccovPretty`.

To learn more about `xccov`, read the [manpage](x-man-page://xccov).

## Example

    % xccov view --report "/path/to/report.xcresult" --json | swift run xccovPretty
    GrubAPI.framework                                               99.37% (1585/1595)
        /Users/JoeUser/Developer/GrubAPI/GrubAPI/
            Authentication/
                Configuration/
                    AuthenticatorConfiguration.swift                91.67% (11/12)
                    DeviceIdentityKeychainConfiguration.swift       100.00% (5/5)
                    SessionKeychainConfiguration.swift              100.00% (24/24)
                Authenticator.swift                                 99.53% (840/844)
                AuthenticatorError.swift                            100.00% (11/11)
                DeviceIdentityDataSource.swift                      100.00% (26/26)
                SessionStorage.swift                                100.00% (30/30)
                Internal API Client/
                    AccountCreationRequest.swift                    100.00% (13/13)
                    AnonymousSessionCreationRequest.swift           100.00% (6/6)
                    AnonymousSessionRefreshRequest.swift            100.00% (6/6)
                    APIClient.swift                                 95.00% (19/20)
                    APIClientProtocol.swift                         100.00% (84/84)
                    AuthenticatedSessionFetchRequest.swift          100.00% (6/6)
                    AuthenticatedSessionRefreshRequest.swift        100.00% (6/6)
                    CredentialUpdateRequest.swift                   100.00% (34/34)
                    DeviceIdentityAuthenticationRequest.swift       100.00% (6/6)
                    LogoutRequest.swift                             100.00% (8/8)
                    PasswordAuthenticationRequest.swift             100.00% (12/12)
                    ThirdPartyAccountAuthenticationRequest.swift    100.00% (40/40)
            Categories and Extensions/
                HTTPHeaderItem+BearerTokens.swift                   100.00% (3/3)
                Logger+PermissiveDecodableArray.swift               100.00% (19/19)
                Result+ErrorPredicates.swift                        100.00% (14/14)
            GrubAPI.swift                                           50.00% (3/6)
            Models/
                AnonymousSession.swift                              100.00% (16/16)
                AuthenticatedSession.swift                          100.00% (22/22)
                AuthenticationScope.swift                           100.00% (3/3)
                Claim.swift                                         100.00% (6/6)
                ClientID.swift                                      100.00% (3/3)
                Credential.swift                                    100.00% (27/27)
                OpenIDConnectTokenResponse.swift                    100.00% (3/3)
                RequestValidationError.swift                        96.15% (25/26)
                SecurityBrand.swift                                 100.00% (3/3)
                Session.swift                                       100.00% (8/8)
                SessionHandle.swift                                 100.00% (45/45)
                SignedDeviceIdentityToken.swift                     100.00% (3/3)
                ThirdPartyAccountConnection.swift                   100.00% (7/7)
                ValidationMessage.swift                             100.00% (75/75)
            Security API Client/
                CredentialFetchRequest.swift                        100.00% (34/34)
                SecurityAPIClient.swift                             100.00% (30/30)
                ThirdPartyAccountConnectionRequest.swift            100.00% (26/26)
                UserProfileUpdateRequest.swift                      100.00% (11/11)
            Utilities/
                StandardJSONResponseHandler.swift                   100.00% (9/9)
                VoidHTTPResponseTransformer.swift                   100.00% (3/3)


## License

All code is licensed under the MIT license. Do with it as you will.
