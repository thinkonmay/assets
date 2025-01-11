certutil -Enterprise -Addstore "TrustedPublisher" .\mm.cer
.\devcon.exe install .\mm.inf "Root\Parsec\VDA"