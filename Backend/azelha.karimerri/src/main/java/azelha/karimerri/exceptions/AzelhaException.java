package azelha.karimerri.exceptions;


public class AzelhaException extends RuntimeException
{
	private static final long serialVersionUID = 1L;

	public AzelhaException()
	{
		super();
	}

	public AzelhaException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace)
	{
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public AzelhaException(String message, Throwable cause)
	{
		super(message, cause);
	}

	public AzelhaException(String message)
	{
		super(message);
	}

	public AzelhaException(Throwable cause)
	{
		super(cause);
	}
	
}
