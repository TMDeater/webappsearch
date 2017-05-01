package Pack;

import java.util.Collection;
import java.util.LinkedList;

/**
 * Created by MSI on 2017/5/1.
 */
public class NoDuplicatesList<E> extends LinkedList<E> {
    @Override
    public boolean add(E e) {
        if (this.contains(e)) {
            return false;
        }
        else {
            return super.add(e);
        }
    }

    @Override
    public boolean addAll(Collection<? extends E> collection) {
        Collection<E> copy = new LinkedList<E>(collection);
        copy.removeAll(this);
        return super.addAll(copy);
    }

    @Override
    public boolean addAll(int index, Collection<? extends E> collection) {
        Collection<E> copy = new LinkedList<E>(collection);
        copy.removeAll(this);
        return super.addAll(index, copy);
    }

    @Override
    public void add(int index, E element) {
        if (this.contains(element)) {
            return;
        }
        else {
            super.add(index, element);
        }
    }

    public static void main(String args[]){
        NoDuplicatesList<String> list = new NoDuplicatesList<>();
        list.add("aaa");
        list.add("aaa");list.add("aaa");list.add("aaa");
        System.out.println(list.size());
    }
}
