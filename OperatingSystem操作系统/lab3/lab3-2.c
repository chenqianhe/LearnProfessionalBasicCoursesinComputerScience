#include <linux/module.h> 
#include <linux/version.h> 
#include <linux/types.h> 
#include <linux/fs.h> 
#include <linux/mm.h> 
#include <linux/errno.h> 
#include <asm/segment.h> 
#include <linux/uaccess.h>

char myData[100] = {0};


long myMajor = 0;
static ssize_t myread(struct file *filep, char *buf, size_t count, loff_t*f_pos)
{  
	char *dev = filep->private_data;
	int i = 0;
	for(; i < count; i++) {   
        put_user(dev[i],buf++);   
    }   
	return count; 
} 

static ssize_t mywrite(struct file *filep, const char *buf, size_t count, loff_t*f_pos) 
{ 
	int ret = 0;
	size_t avail = 1024 - *f_pos;
  	char *dev = filep->private_data;
  	memset(dev + *f_pos, 0, avail);

	if (count > avail) {
    	if (copy_from_user(dev + *f_pos, buf, avail) != 0)
			return -1;
		*f_pos += avail;
		ret = avail;
  	} else {
    	if (copy_from_user(dev + *f_pos, buf, count) != 0)
      		return -1;
		*f_pos += count;
		ret = count;
  	}

  	printk(KERN_INFO "Written %u bytes\n", ret);

	return ret; 
} 
 
static int myopen(struct inode *inode,struct file *filep) 
{
	filep->private_data = myData;
	return 0; 
} 
 
static int myrelease(struct inode *inode,struct file *filep)
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
	result = register_chrdev(0, "charWRNEW2", &my_fops); 
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
	unregister_chrdev(myMajor,"charWRNEW2"); 
} 

MODULE_LICENSE("GPL");
module_init(init_mymodule);
module_exit(cleanup_mymodule);