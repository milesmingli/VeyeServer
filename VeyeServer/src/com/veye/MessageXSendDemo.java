package com.veye;

import utils.ConfigLoader;
import config.AppConfig;
import lib.MESSAGEXsend;

public class MessageXSendDemo {

	public static void main(String[] args) {

		try {

			AppConfig config = ConfigLoader
					.load(ConfigLoader.ConfigType.Message);
			MESSAGEXsend submail = new MESSAGEXsend(config);
			submail.addTo("15901382233");
			submail.setProject("kDPCE4");
			submail.addVar("code", "12345");
			submail.xsend();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
