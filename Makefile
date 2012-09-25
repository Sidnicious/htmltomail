all:
	cc -o htmltomail Helpers/ATMailHelper.m htmltomail.m -framework Cocoa -framework WebKit
