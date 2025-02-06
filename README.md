1: MRU.vim  
  下载位置：https://github.com/yegappan/mru  
  官方网站：https://www.vim.org/scripts/script.php?script_id=521  
  中文教程：http://it.taocms.org/06/712.htm

2: TagList.vim  
  下载位置: https://sourceforge.net/projects/vim-taglist/files/  
  官方网站: https://www.vim.org/scripts/script.php?script_id=273  
  中文教程：https://www.cnblogs.com/diegodu/p/7088596.html

5: code_complete.vim

3: CTags (yum install ctags)
  下载位置:
  中文教程:

4: cscope (yum install cscope)
  下载位置:
  中文教程:


5: 配置sshkey
    https://cloud.tencent.com/developer/article/1861466

6:  生成ssh key 
    if:   ssh-keygen -t ed25519 -C "your_email@example.com" 
    else: ssh-keygen -t rsa -b 4096 -C "your_email@example.com" 
    else: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

7: sudo yum update  
    sudo yum groupinstall "Development Tools"   
    sudo yum install openssl-devel  
    sudo yum update openssl

8: 无法访问github.com
   在该网址上找到搜www.github.com 找到所有可以访问的ip (https://www.whatsmydns.net/#A/www.github.com)
   用机器ping 某个ip，找到访问最快的一个ip
   sudo vim /etc/hosts
   添加一行：140.82.112.3 github.com
   sudo reboot
