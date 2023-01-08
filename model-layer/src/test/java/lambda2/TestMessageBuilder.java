package lambda2;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import lambda1.MessageBuilder;
public class TestMessageBuilder {
    @Test
    public void testHelloWorld() {
        assertEquals("hello world", MessageBuilder.getHelloWorld());
    }

    @Test
    public void testNumber10() {
        assertEquals(10, MessageBuilder.getNumber10());
    } 

}
