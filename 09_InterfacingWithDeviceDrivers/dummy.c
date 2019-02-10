/* A device driver named `dummy`, which creates four devices
 * that are accessed through `dev/dummy0` to `/dev/dummy3`
 *
 * Use it as:
 * $ echo hello > /dev/dummy0
 * > dummy_open
 * > dummy_write 6
 * > dummy_release
 */
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/device.h>


#define DEVICE_NAME "dummy"
#define MAJOR_NUM 42
#define NUM_DEVICES 4

static struct class *dummy_class;



/* The file operations for this driver are implemented by `dummy_open()`,
 * `dummy_read()`, `dummy_write()`, and dummy_release() and are called 
 * when a user space program calls `open(2)`, `read(2)`, `write(2)`, and
 * `close(2)`. */

static int dummy_open(struct inode *inode, struct file *file)
{
	pr_info("%s\n", __func__);
	return 0;
}

static int dummy_release(struct inode *inode, struct file *file)
{
	pr_info("%s\n", __func__);
	return 0;
}

static ssize_t dummy_read(struct file *file, char *buffer, size_t length, loff_t* offset)
{
	pr_info("%s\n", __func__, length);
	return length;
}

static ssize_t dummy_write(struct file *file, const char *buffer, size_t length, loff_t* offset)
{
	pr_info("%s\n", __func__, length);
	return length;
}

struct file_operations dummy_fops = {
	.owner = THIS_MODULE,
	.open = dummy_open,
	.release = dummy_release,
	.read = dummy_read,
	.write = dummy_write,
};

int __init dummy_init(void)
{
	int ret;
	int i;
	printk("Dummy loaded\n");

	/* `register_chrdev` tells the kernel that there is a
	 * driver with a major number of 42 , it doesn't say
	 * anything about the class of driver, and so it will not
	 * create an entry in `/sys/class`. Without an entry in
	 * `/sys/class`, the device manager cannot create device nodes. */
	ret = register_chrdev(MAJOR_NUM, DEVICE_NAME);

	/* create a device class, `dummy` and four devices of that class called 
	 * `dummy0` to `dummy3`. The result is that the `/sys/class/dummy`
	 * directory is created when the driver is initialized, containing
	 * subdirectories `dummy0` to `dummy3`. Each of the subdirectories contains
	 * a file, `dev`, with the major and minor numbers of the device.
	 * This is all that a device manager needs to create
	 * device nodes: `/dev/dummy0` to `/dev/dummy3`. */
	for (i = 0; i < NUM_DEVICES; ++i) {
		device_create(dummy_class, NULL,
					  MKDEV(MAJOR_NUM, i), NULL, "dummy%d", i);
	}

	return 0;
}

/* The `dummy_exit` function has to release the resources claimed by
 * `dummy_init`, which here means freeing up the device class and 
 * major number.*/
void __exit dummy_exit(void)
{
	int i;
	for (i = 0; i < NUM_DEVICES; ++i) {
		device_destroy(dummy_class, MKDEV(MAJOR_NUM, i));
	}

	class_destroy(dummy_class);
	unregister_chrdev(MAJOR_NUM, DEVICE_NAME);
	printk("Dummy unloaded\n");
}

/* The macros called `module_init` and `module_exit` specify the
 * functions to be called when the module is loaded and unloaded
 */
module_init(dummy_init);
module_exit(dummy_exit);

/* `MODULE_*` add some basic information about the module, which can be retrieved from the
 * compiled kernel module using the `modinfo` command.*
 */

MODULE_LICENSE("GPL");
MODULE_AUTOR("C.S");
MODULE_DESCRIPTION("A dummy driver");

