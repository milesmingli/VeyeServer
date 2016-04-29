package manage.user;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class Mail {
	
	private static String host ;
	private static String username ;
	private static String password ;
	private static String personal ;
	public static Properties getProperties(){
		Properties properties = new Properties();
        // �����ʼ�������
		
	
		host = "smtp.mxhichina.com";
		username = "info@v-eye.net";
		password = "Qing19910216";
		personal = "veye";
		
        properties.put("mail.smtp.host", host);
        // ��֤
        properties.put("mail.smtp.auth", "true");
        return properties;
	}
	
	public static Session getMailSession(){
		// ���������½�һ���ʼ��Ự
        return Session.getInstance(getProperties(), new Authenticator()
        {
            public PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication
                (username, password);
            }
        });
        
	}
	
	public static boolean sendMail(String toAddress,String title ,String content){
		return sendMail(toAddress, personal, title, content);
		
	}
	
	@SuppressWarnings("static-access")
	//FIXME:����쳣����ʾ�ʼ�������������⣬�ʼ����ͣ���Ϊ�첽���ͣ�����첽�����ͳɹ�������Ϣ��ô����
	public static boolean sendMail(String toAddress, String personal ,String title ,String content){
		final MimeMessage mailMessage;
	    final Transport trans ;
	    Session mailSession = getMailSession();
		
		// ������Ϣ����
        mailMessage = new MimeMessage(mailSession);
        try {
			// ������
			mailMessage.setFrom(new InternetAddress(username,personal));
			// �ռ���
			mailMessage.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(toAddress));
			// ����
			mailMessage.setSubject(title);
			// ����
//			mailMessage.setText(content);
			mailMessage.setContent(content,"text/html;charset=utf-8");
			// ����ʱ��
			mailMessage.setSentDate(new Date());
			// �洢��Ϣ
			mailMessage.saveChanges();
			trans = mailSession.getTransport("smtp");
			
			//FIXME ��Ҫ�޸�Ϊ�첽������Ϣ
			trans.send(mailMessage);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false ;
		}
        
		return true ;
	}
	
	
	public static void main(String[] args) {
	/*	String ss="582971426@qq.com";
		Mail.sendMail(ss,"veye", "����", "����һ������ʼ�");*/
	}
}
