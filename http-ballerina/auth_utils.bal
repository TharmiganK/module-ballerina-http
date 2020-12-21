// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
//import ballerina/reflect;
//
//# Auth annotation module.
//const string ANN_MODULE = "ballerina/http:1.0.4";
//# Resource level annotation name.
//const string RESOURCE_ANN_NAME = "ResourceConfig";
//# Service level annotation name.
//const string SERVICE_ANN_NAME = "ServiceConfig";

# Represents the Authorization header name.
public const string AUTH_HEADER = "Authorization";

# The prefix used to denote the Basic authentication scheme.
public const string AUTH_SCHEME_BASIC = "Basic";

# The prefix used to denote the Bearer authentication scheme.
public const string AUTH_SCHEME_BEARER = "Bearer";

//# Specifies how to send the authentication credentials when exchanging tokens.
//public type CredentialBearer AUTH_HEADER_BEARER|POST_BODY_BEARER|NO_BEARER;
//
//# Indicates that the authentication credentials should be sent via the Authentication header.
//public const AUTH_HEADER_BEARER = "AUTH_HEADER_BEARER";
//
//# Indicates that the Authentication credentials should be sent via the body of the POST request.
//public const POST_BODY_BEARER = "POST_BODY_BEARER";
//
//# Indicates that the authentication credentials should not be sent.
//public const NO_BEARER = "NO_BEARER";
//
//# Indicates the status code.
//public const STATUS_CODE = "STATUS_CODE";
//
//# Represents inbound auth handler patterns.
//public type InboundAuthHandlers InboundAuthHandler[]|InboundAuthHandler[][];
//
//# Represents scopes patterns.
//public type Scopes string[]|string[][];
//
//# Extracts the Authorization header value from the request.
//#
//# + req - The `Request` instance
//# + return - Value of the Authorization header
//public isolated function extractAuthorizationHeaderValue(Request req) returns @tainted string {
//    // extract authorization header
//    return req.getHeader(AUTH_HEADER);
//}
//
//# Checks whether the calling resource is secured by evaluating the authentication hierarchy.
//#
//# + context - The `FilterContext` instance
//# + return - The status of calling resource is secured or not
//public isolated function isResourceSecured(FilterContext context) returns boolean {
//    ResourceAuth? resourceLevelAuthAnn = getResourceAuthConfig(context);
//    ServiceAuth? serviceLevelAuthAnn = getServiceAuthConfig(context);
//
//    boolean? resourceSecured = isResourceAuthEnabled(resourceLevelAuthAnn);
//    boolean serviceSecured = isServiceAuthEnabled(serviceLevelAuthAnn);
//
//    if (resourceSecured is boolean) {
//        return resourceSecured;
//    } else {
//        return serviceSecured;
//    }
//}
//
//# Tries to retrieve the inbound authentication handlers based on their hierarchy
//# (i.e., first from the resource level and then from the service level, if it is not there at the resource level).
//#
//# + context - The `FilterContext` instance
//# + return - The authentication handlers or a boolean value indicating whether it is needed to engage listener-level handlers or not
//isolated function getAuthHandlers(FilterContext context) returns InboundAuthHandlers|boolean {
//    ResourceAuth? resourceLevelAuthAnn = getResourceAuthConfig(context);
//    ServiceAuth? serviceLevelAuthAnn = getServiceAuthConfig(context);
//
//    // check if authentication is enabled for resource and service
//    boolean? resourceSecured = isResourceAuthEnabled(resourceLevelAuthAnn);
//    boolean serviceSecured = isServiceAuthEnabled(serviceLevelAuthAnn);
//
//    if (resourceSecured is boolean) {
//        // if resource is not secured, no need to check further.
//        if (!resourceSecured) {
//            log:printError("Resource is not secured. `enabled: false`.");
//            return false;
//        }
//        // checks if Auth providers are given at the resource level.
//        if (resourceLevelAuthAnn is ResourceAuth) {
//            InboundAuthHandlers? resourceAuthHandlers = resourceLevelAuthAnn?.authHandlers;
//            if (resourceAuthHandlers is InboundAuthHandlers) {
//                return resourceAuthHandlers;
//            } else {
//                // checks if service is secured.
//                if (serviceSecured) {
//                    // Checks if Auth providers are given at the service level.
//                    if (serviceLevelAuthAnn is ServiceAuth) {
//                        InboundAuthHandlers? serviceAuthHandlers = serviceLevelAuthAnn?.authHandlers;
//                        if (serviceAuthHandlers is InboundAuthHandlers) {
//                            return serviceAuthHandlers;
//                        }
//                    }
//                }
//            }
//        } else {
//            // checks if service is secured.
//            if (serviceSecured) {
//                // Checks if Auth providers are given at the service level.
//                if (serviceLevelAuthAnn is ServiceAuth) {
//                    InboundAuthHandlers? serviceAuthHandlers = serviceLevelAuthAnn?.authHandlers;
//                    if (serviceAuthHandlers is InboundAuthHandlers) {
//                        return serviceAuthHandlers;
//                    }
//                }
//            }
//        }
//    } else {
//        // checks if Auth providers are given at the resource level.
//        if (resourceLevelAuthAnn is ResourceAuth) {
//            InboundAuthHandlers? resourceAuthHandlers = resourceLevelAuthAnn?.authHandlers;
//            if (resourceAuthHandlers is InboundAuthHandlers) {
//                return resourceAuthHandlers;
//            }
//        }
//        // if service is not secured, no need to check further.
//        if (!serviceSecured) {
//            log:printError("Service is not secured. `enabled: false`.");
//            return false;
//        }
//        // Checks if Auth providers are given at the service level.
//        if (serviceLevelAuthAnn is ServiceAuth) {
//            InboundAuthHandlers? serviceAuthHandlers = serviceLevelAuthAnn?.authHandlers;
//            if (serviceAuthHandlers is InboundAuthHandlers) {
//                return serviceAuthHandlers;
//            }
//        }
//    }
//    return true;
//}
//
//# Retrieves the authorization scopes hierarchically - first from the resource level and then
//# from the service level if it is not there in the resource level.
//#
//# + context - `FilterContext` instance
//# + return - Authorization scopes or whether it is needed to engage listener level scopes or not
//isolated function getScopes(FilterContext context) returns Scopes|boolean {
//    ResourceAuth? resourceLevelAuthAnn = getResourceAuthConfig(context);
//    ServiceAuth? serviceLevelAuthAnn = getServiceAuthConfig(context);
//
//     // check if authentication is enabled for resource and service
//    boolean? resourceSecured = isResourceAuthEnabled(resourceLevelAuthAnn);
//    boolean serviceSecured = isServiceAuthEnabled(serviceLevelAuthAnn);
//
//    if (resourceSecured is boolean) {
//        // if resource is not secured, no need to check further.
//        if (!resourceSecured) {
//            // log:printDebug(isolated function () returns string {
//            //     return "Resource is not secured. `enabled: false`.";
//            // });
//            return false;
//        }
//        // checks if scopes are given at the resource level.
//        if (resourceLevelAuthAnn is ResourceAuth) {
//            Scopes? resourceScopes = resourceLevelAuthAnn?.scopes;
//            if (resourceScopes is Scopes) {
//                return resourceScopes;
//            } else {
//                // checks if service is secured.
//                if (serviceSecured) {
//                    // Checks if scopes are given at the service level.
//                    if (serviceLevelAuthAnn is ServiceAuth) {
//                        Scopes? serviceScopes = serviceLevelAuthAnn?.scopes;
//                        if (serviceScopes is Scopes) {
//                            return serviceScopes;
//                        }
//                    }
//                }
//            }
//        } else {
//            // checks if service is secured.
//            if (serviceSecured) {
//                // Checks if scopes are given at the service level.
//                if (serviceLevelAuthAnn is ServiceAuth) {
//                    Scopes? serviceScopes = serviceLevelAuthAnn?.scopes;
//                    if (serviceScopes is Scopes) {
//                        return serviceScopes;
//                    }
//                }
//            }
//        }
//    } else {
//        // checks if scopes are given at the resource level.
//        if (resourceLevelAuthAnn is ResourceAuth) {
//            Scopes? resourceScopes = resourceLevelAuthAnn?.scopes;
//            if (resourceScopes is Scopes) {
//                return resourceScopes;
//            }
//        }
//        // if service is not secured, no need to check further.
//        if (!serviceSecured) {
//            //log:printDebug(isolated function () returns string {
//            //    return "Service is not secured. `enabled: false`.";
//            //});
//            return false;
//        }
//        // Checks if scopes are given at the service level.
//        if (serviceLevelAuthAnn is ServiceAuth) {
//            Scopes? serviceScopes = serviceLevelAuthAnn?.scopes;
//            if (serviceScopes is Scopes) {
//                return serviceScopes;
//            }
//        }
//    }
//    return true;
//}
//
//# Retrieves the authentication annotation value for the service level.
//#
//# + context - The `FilterContext` instance
//# + return - The service-level authentication annotations or else `()`
//isolated function getServiceAuthConfig(FilterContext context) returns ServiceAuth? {
//    // any annData = reflect:getServiceAnnotations(context.getService(), SERVICE_ANN_NAME, ANN_MODULE);
//    // if (!(annData is ())) {
//    //     HttpServiceConfig serviceConfig = <HttpServiceConfig> annData;
//    //     return serviceConfig?.auth;
//    // }
//}
//
//# Retrieves the authentication annotation value for the resource level and service level.
//#
//# + context - The `FilterContext` instance
//# + return - The resource-level and service-level authentication annotations
//isolated function getResourceAuthConfig(FilterContext context) returns ResourceAuth? {
//    // any annData = reflect:getResourceAnnotations(context.getService(), context.getResourceName(), RESOURCE_ANN_NAME,
//    //                                              ANN_MODULE);
//    // if (!(annData is ())) {
//    //     HttpResourceConfig resourceConfig = <HttpResourceConfig> annData;
//    //     return resourceConfig?.auth;
//    // }
//}
//
//# Checks whether the `http:ResourceConfig` has `http:WebSocketUpgradeConfig` or not.
//#
//# + context - The `FilterContext` instance
//# + return - Whether the `http:ResourceConfig` has `http:WebSocketUpgradeConfig` or not
//isolated function isWebSocketUpgradeRequest(FilterContext context) returns boolean {
//    // any annData = reflect:getResourceAnnotations(context.getService(), context.getResourceName(), RESOURCE_ANN_NAME,
//    //                                              ANN_MODULE);
//    // if (annData is ()) {
//    //     return false;
//    // }
//    // HttpResourceConfig resourceConfig = <HttpResourceConfig> annData;
//    // if (resourceConfig?.webSocketUpgrade is WebSocketUpgradeConfig) {
//    //     return true;
//    // }
//    return false;
//}
//
//# Checks whether the service is secured by evaluating the enabled flag configured by the user.
//#
//# + serviceAuth - Service auth annotation
//# + return - Whether the service is secured or not
//isolated function isServiceAuthEnabled(ServiceAuth? serviceAuth) returns boolean {
//    if (serviceAuth is ServiceAuth) {
//        return serviceAuth.enabled;
//    }
//    return true;
//}
//
//# Checks whether the resource is secured by evaluating the enabled flag configured by the user.
//#
//# + resourceAuth - Resource auth annotation
//# + return - Whether the resource is secured or not
//isolated function isResourceAuthEnabled(ResourceAuth? resourceAuth) returns boolean? {
//    if (resourceAuth is ResourceAuth) {
//        return resourceAuth?.enabled;
//    }
//}

# Defines the authentication configurations that a HTTP client may have
public type ClientAuthConfig CredentialsConfig|BearerTokenConfig|JwtIssuerConfig|OAuth2GrantConfig;

# Logs and prepares the `error` as an `http:ClientAuthError`.
#
# + message - The error message
# + err - The `error` instance
# + return - The prepared `http:ClientAuthError` instance
isolated function prepareClientAuthError(string message, error? err = ()) returns ClientAuthError {
    log:printError(message, err = err);
    if (err is error) {
        return ClientAuthError(message, err);
    }
    return ClientAuthError(message);
}
