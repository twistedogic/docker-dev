c = get_config()
 
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888 # or whatever you want; be aware of conflicts with CDH
