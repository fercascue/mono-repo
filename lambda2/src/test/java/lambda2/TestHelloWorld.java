package lambda2;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import lambda1.HelloWorld;

public class TestHelloWorld {
	 @Test
	    public void testLucky() {
	        assertEquals(6, HelloWorld.getLucky());
	    }
}
