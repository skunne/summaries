import sys      # sys.argv
import pybtex.database

def get_list_of_cited_keys(texfile):
    list_of_keys = []
    with open(texfile) as f:
        for line in f:
            pos = line.find('\\cite{', 0)
            while (pos != -1):
                pos = pos + 6
                endpos = line.find('}', pos)
                if endpos == -1:
                    print('!!WARNING!! found \\cite{ with no matching } on line:')
                    print('    ', line)
                keys = line[pos:endpos].split(',')
                list_of_keys.extend(keys)
                pos = line.find("\\cite{", endpos)
    return list_of_keys

def get_bibliography(bibfile):
    bib_data = pybtex.database.parse_file(bibfile)
    return bib_data

def remove_cited_entries(list_of_cited_keys, bibliography):
    for key in list_of_cited_keys:
        bibliography.entries.pop(key, None)     # this raises NotImplementedError!!
    return bibliography

def print_bibliography(biblio):
    print(biblio.to_string('bibtex'))

def print_only_uncited(list_of_cited_keys, biblio):
    for key in biblio.entries:
        if key not in list_of_cited_keys:
            print(key)

def print_usage():
    print('SYNOPSIS')
    print()
    print('{} [-h | --help]'.format(sys.argv[0]))
    print('    print this help message and exit')
    print()
    print('{} texfile bibfile'.format(sys.argv[0]))
    print('    Parse a latex file and a bibliography file.')
    print('    Print the list of bibliography entries')
    print('    which are not cited in the tex file.')
    print()

def main():
    if len(sys.argv) == 3:
        texfile = sys.argv[1]
        bibfile = sys.argv[2]
        list_of_cited_keys = get_list_of_cited_keys(texfile)
        bibliography = get_bibliography(bibfile)
        #uncited_bibliography = remove_cited_entries(list_of_cited_keys, bibliography)
        #print_bibliography(uncited_bibliography)
        print_only_uncited(list_of_cited_keys, bibliography)
    else:
        print_usage()

if __name__=='__main__':
    main()
