#include <linux/module.h> 
#include <linux/version.h> 
#include <linux/types.h> 
#include <linux/fs.h> 
#include <linux/mm.h> 
#include <linux/errno.h> 
#include <asm/segment.h> 
#include <linux/uaccess.h>


long myMajor = 0;
static ssize_t myread(struct file *flip,char *buf,size_t count, loff_t*f_pos)
{  
	int i = count;
	for(; i > 0 ; i--) {   
        put_user(i,buf++);   
    }   
	return count; 
} 

static ssize_t mywrite(struct file *flip,const char *file,size_t count, loff_t*f_pos) 
{ 
	return count; 
} 
 
static int myopen(struct inode *inode,struct file *file) 
{
	return 0; 
} 
 
static int myrelease(struct inode *inode,struct file *file)
{
	return 0;
}

struct file_operations my_fops = {
	.read = myread,
	.write = mywrite,
	.open = myopen,
	.release = myrelease
};

static int init_mymodule(void) 
{ 
	int result;
	result = register_chrdev(0, "charWR", &my_fops); 
	if (result < 0) { 
		printk(KERN_INFO "Init fail!\n"); 
		return result;
	} 
	if (myMajor == 0) {
        myMajor = result;
    }
    return 0; 
}


static void cleanup_mymodule(void) 
{ 
	unregister_chrdev(myMajor,"charWR"); 
} 

MODULE_LICENSE("GPL");
module_init(init_mymodule);
module_exit(cleanup_mymodule);