import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  ScanCommand,
  PutCommand,
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "count_visit";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "GET /count":
          let one_day = 86400000;
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: {
              time_stamp: Date.now(),
            },
          })
        );
        body = await dynamo.send(
          new ScanCommand({
              TableName: tableName,
              FilterExpression: 'time_stamp >= :day' ,
              ExpressionAttributeValues: {
                ':day':  Date.now() - one_day,
            },
          })      
        );
        body = body.Count;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers,
  };
};
