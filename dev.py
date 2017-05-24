#! /bin/python

from datetime import date

def main():
    f = open('devlog.txt', 'rU')
    s = f.read()
    f.close()
    index = s.find('==============================================================\n\n\n') + len('==============================================================\n\n\n')
    pre = s[:index + 1]
    allDays = s[index + 1:]
    days = allDays.split('\n\n')
    latest = days[-1]
    latest = latest.split('\n')
    if getDate(latest) == str(date.today()):
        print('same day')
    else:
        print('diff day')
    print(latest)
        
def getDate(l):
    return l[0]

main()
