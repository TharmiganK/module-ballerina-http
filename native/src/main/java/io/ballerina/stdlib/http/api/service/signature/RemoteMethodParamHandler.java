package io.ballerina.stdlib.http.api.service.signature;

import io.ballerina.runtime.api.types.RemoteMethodType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.stdlib.http.api.HttpConstants;

import java.util.ArrayList;
import java.util.List;

import static io.ballerina.stdlib.http.api.HttpConstants.COLON;
import static io.ballerina.stdlib.http.api.HttpConstants.PROTOCOL_HTTP;

/**
 * This class holds the response interceptor remote signature parameters.
 */
public class RemoteMethodParamHandler {

    private final Type[] paramTypes;
    private final RemoteMethodType remoteMethod;
    private final List<Parameter> otherParamList = new ArrayList<>();

    private static final String RES_TYPE = PROTOCOL_HTTP + COLON + HttpConstants.RESPONSE;
    private static final String REQUEST_CONTEXT_TYPE = PROTOCOL_HTTP + COLON + HttpConstants.REQUEST_CONTEXT;
    private static final String CALLER_TYPE = PROTOCOL_HTTP + COLON + HttpConstants.CALLER;

    public RemoteMethodParamHandler(RemoteMethodType remoteMethod) {
        this.remoteMethod = remoteMethod;
        this.paramTypes = remoteMethod.getParameterTypes();
        validateSignatureParams();
    }

    private void validateSignatureParams() {
        for (int index = 0; index < paramTypes.length; index++) {
            Type parameterType = remoteMethod.getParameterTypes()[index];
            String typeName = parameterType.toString();
            switch (typeName) {
                case REQUEST_CONTEXT_TYPE:
                    NonRecurringParam requestContextParam = new NonRecurringParam(index, HttpConstants.REQUEST_CONTEXT);
                    getOtherParamList().add(requestContextParam);
                    break;
                case HttpConstants.STRUCT_GENERIC_ERROR:
                    NonRecurringParam interceptorErrorParam = new NonRecurringParam(index,
                                                                                    HttpConstants.STRUCT_GENERIC_ERROR);
                    getOtherParamList().add(interceptorErrorParam);
                    break;
                case RES_TYPE:
                    NonRecurringParam responseParam = new NonRecurringParam(index, HttpConstants.RESPONSE);
                    getOtherParamList().add(responseParam);
                    break;
                case CALLER_TYPE:
                    NonRecurringParam callerParam = new NonRecurringParam(index, HttpConstants.CALLER);
                    getOtherParamList().add(callerParam);
                    break;
                default:
                    break;
            }
        }
    }

    public int getParamCount() {
        return this.paramTypes.length;
    }

    public List<Parameter> getOtherParamList() {
        return this.otherParamList;
    }
}