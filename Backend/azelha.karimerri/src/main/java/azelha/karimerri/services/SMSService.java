package azelha.karimerri.services;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import azelha.karimerri.entites.SMS;

@Component
public class SMSService {

	// @Value("#{systemEnvironment['TWILIO_ACCOUNT_SID']}")
	private String ACCOUNT_SID = "AC77b8fb7c50f63287da94fd53910de553";

	/*
	 * @Value("#{systemEnvironment['COMPONENT_PARAM_CORS'] ?: 'DEFAULT_VALUE'}")
	 * private String COMPONENT_PARAM_CORS;
	 */

	// @Value("#{systemEnvironment['TWILIO_AUTH_TOKEN']}")
	private String AUTH_TOKEN = "59f5d0880ad904cec9c08e4e5c060bdc";

	// @Value("#{systemEnvironment['TWILIO_PHONE_NUMBER']}")
	private String FROM_NUMBER = "+12058439549";

	public void send(SMS sms) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		// to number, from: always twilio snd a message
		Message message = Message.creator(new PhoneNumber(sms.getTo()), new PhoneNumber(FROM_NUMBER), sms.getMessage())
				.setStatusCallback(URI.create("http://677add1a.ngrok.io/smscallback")).create();
		System.out.println("here is my id:" + message.getSid());// Unique resource ID created to manage this transaction

	}

	public void call() throws URISyntaxException {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

		Call call = Call.creator(new PhoneNumber("+15148917629"), new PhoneNumber("+12058439549"),
				new URI("http://demo.twilio.com/docs/voice.xml")).create();

		System.out.println(call.getSid());
	}

	public void receive(MultiValueMap<String, String> smscallback) {
	}
}