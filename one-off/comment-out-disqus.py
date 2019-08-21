import os, sys

def comment_out_disqus(fname):
    print(fname)
    v = []
    changed = False
    for x in open(fname).readlines():
        if 'disqus' in x and '<!--' not in x:
            x = '<!-- ' + x[:-1] + ' -->' + x[-1]
            changed = True
        v.append(x)
    if changed:
        print('changed')
        open(fname,'w').write(''.join(v))

def do_it():
    rootDir = '../www'
    for dirName, subdirList, fileList in os.walk(rootDir):
        for fname in fileList:
            if fname.endswith('.html'):
                comment_out_disqus(dirName + '/' + fname)

do_it()